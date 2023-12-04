variable "a" {
  default = ""
}

variable "list" {
  type = list(string)
  default = ["a", "b", "c", "id"]
}

variable "map" {
  type = map(string)
  default = {
    a = "foo"
    b = "bar"
    c = "baz"
  }
}

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