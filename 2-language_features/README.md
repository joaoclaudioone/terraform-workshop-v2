# Languages features

In this section we will explore some languages features, like expressions and functions. There are a lot of useful features, that we will not go into details.

## Meta-arguments

Meta-arguments in Terraform are special arguments that can be used with resource blocks and modules to control their behavior or influence the infrastructure provisioning process. They provide additional configuration options beyond the regular resource-specific arguments.

### depends_on

Terraform automatically generates dependency graph based on references. This meta-argument let us enforce that one resource will be create before another. 

```hcl
# Resource A
resource "aws_instance" "instance_a" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  # other configurations...
}

# Resource B depends on Resource A
resource "aws_instance" "instance_b" {
  ami           = "ami-87654321"
  instance_type = "t2.micro"
  # other configurations...

  # Explicitly specify the dependency
  depends_on = [aws_instance.instance_a]
}
```

### count

By default, a resource block configures one real infrastructure object. The `count` meta-argument accepts a whole number, and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

```hcl
resource "aws_instance" "server" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}
```

When `count` is set, Terraform distinguishes between the block itself and the multiple resource or module instances associated with it. Instances are identified by an index number, starting with 0.

```hcl
aws_instance.server[0].id
```

### for_each

The `for_each` meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

```hcl
# Define a map of instance configurations
variable "instance_configs" {
  type = map(object({
    ami           = string
    instance_type = string
    # other configurations...
  }))
  default = {
    instance_a = {
      ami           = "ami-12345678"
      instance_type = "t2.micro"
      # other configurations...
    },
    instance_b = {
      ami           = "ami-87654321"
      instance_type = "t2.micro"
      # other configurations...
    },
  }
}

# Create instances using for_each
resource "aws_instance" "instances" {
  for_each = var.instance_configs

  ami           = each.value.ami
  instance_type = each.value.instance_type
  # other configurations...
}

```

#### When to Use `for_each` Instead of `count`

If your instances are almost identical, `count` is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use `for_each`.

### Lifecycle

Lifecycle is a nested block that can appear within a resource block. The `lifecycle` block and its contents are meta-arguments, available for all resource blocks regardless of type.

The arguments available within a lifecycle block are `create_before_destroy`, `prevent_destroy`, `ignore_changes`, and `replace_triggered_by`.

- `create_before_destroy` (bool) - By default, when Terraform must change a resource argument that cannot be updated in-place due to remote API limitations, Terraform will instead destroy the existing object and then create a new replacement object with the new configured arguments.

- `prevent_destroy` (bool) - This meta-argument, when set to true, will cause Terraform to reject with an error any plan that would destroy the infrastructure object associated with the resource, as long as the argument remains present in the configuration.

- `ignore_changes` (list of attribute names) - By default, Terraform detects any difference in the current settings of a real infrastructure object and plans to update the remote object to match configuration.

```hcl
resource "aws_instance" "example" {
  # ...

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}
```

- `replace_triggered_by` (list of resource or attribute references) - Replaces the resource when any of the referenced items change. Supply a list of expressions referencing managed resources, instances, or instance attributes.

```hcl
resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = "ami-abc123"

  lifecycle {
    # The AMI ID must refer to an AMI that contains an operating system
    # for the `x86_64` architecture.
    precondition {
      condition     = data.aws_ami.example.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture."
    }
  }
}
```


## Expressions

Expressions refer to or compute values within a configuration. The simplest expressions are just literal values, like "hello" or 5, but the Terraform language also allows more complex expressions such as references to data exported by resources, arithmetic, conditional evaluation, and a number of built-in functions.

Expressions can be used in a number of places in the Terraform language, but some contexts limit which expression constructs are allowed, such as requiring a literal value of a particular type or forbidding references to resource attributes. Each language feature's documentation describes any restrictions it places on expressions.

### Types

Strings, numbers, and bools are sometimes called primitive types. Lists/tuples and maps/objects are sometimes called complex types, structural types, or collection types.

| Type | Description | Example |
|------|-------------|:-------:|
| `string` | A sequence of Unicode characters representing some text | `"hello"` |
| `number` | A numeric value. The number type can represent both whole numbers like `15` and fractional values like `6.283185` | `5` |
| `bool` | A boolean value, bool values can be used in conditional logic. | `true` |
| `list` or `tuple` | A sequence of values. Identify elements in a list with consecutive whole numbers, starting with zero. | `["foo", 15, true]` |
| `set` | A collection of unique values that do not have any secondary identifiers or ordering. | `["eu-west-1a", "eu-west-1b", "eu-west-1c"]` |
| `map` or `object` | A group of values identified by named labels  | `{name = "Mabel", age = 52}` |
| `null` | A value that represents absence or omission. If you set an argument of a resource to null, Terraform behaves as though you had completely omitted it — it will use the argument's default value if it has one, or raise an error if the argument is mandatory. null is most useful in conditional expressions, so you can dynamically omit an argument if a condition isn't met.  | `null` |

#### Type conversion

Terraform automatically converts number and bool values to strings when needed. It also converts strings to numbers or bools, as long as the string contains a valid representation of a number or bool value.

### Arithmetic and Logical Operators

An operator is a type of expression that transforms or combines one or more other expressions. Operators either combine two values in some way to produce a third result value, or transform a single given value to produce a single result.

| Type | Operators | 
|-----------|:-------------:|
| Arithmetic | `+, -, *, /, %` |
| Comparison | `>, >=, <, <=` |
| Equality | `==, !+` |
| Logical | `\|\|(or), &&(and), !(not)` |

### Conditional

A conditional expression uses the value of a boolean expression to select one of two values.

The condition can be any expression that resolves to a boolean value. This will usually be an expression that uses the equality, comparison, or logical operators.

```hcl
condition ? true_val : false_val
```

A common use of conditional expressions is to define defaults to replace invalid values:

```hcl
var.a != "" ? var.a : "default-a"
```

### For

A for expression creates a complex type value by transforming another complex type value. Each element in the input value can correspond to either one or zero values in the result, and an arbitrary expression can be used to transform each input element into an output element.

For example, if var.list were a list of strings, then the following expression would produce a tuple of strings with all-uppercase letters:

```hcl
variable "list" {
  type = list(string)
  default = ["a", "b", "c"]
}

[for s in var.list : upper(s)]
[
  "A",
  "B",
  "C",
]
```

In the above example the input was a list, but we can also work with a set, map or object.

```hcl
variable "map" {
  type = map(string)
  default = {
    a = "foo"
    b = "bar"
    c = "baz"
  }
}

[for k, v in var.map : length(k) + length(v)]
[
  4,
  4,
  4,
]
```

### Splat

A splat expression provides a more concise way to express a common operation that could otherwise be performed with a for expression.

If var.list is a list of objects that all have an attribute id, then a list of the ids could be produced with the following for expression:

```hcl
variable "list_obj" {
  type = list(object({
    id = string
    name = string
  }))
  default = [ {
    id = "1"
    name = "foo"
  },
  {
    id = "2"
    name = "bar"
  }
    ]
}

[for o in var.list_obj : o.id]
[
  1,
  2,
]
```

This is equivalent to the following splat expression:

```hcl
var.list_obj[*].id
tolist([
  1,
  2,
])
```

[Expressions Exercise](./2.1-expressions_exercise/README.md)

## Dynamic blocks
