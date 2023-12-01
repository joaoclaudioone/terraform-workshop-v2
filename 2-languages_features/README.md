# Languages features

In this section we will explore some languages features, like expressions and functions.

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
