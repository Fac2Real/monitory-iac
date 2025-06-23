variable "neptune_subnet_groups" {
  description = "Neptune subnet group 정의 map"
  type = map(object({
    name        = string
    description = string
    subnet_ids  = list(string)
  }))
  default = {}
}

variable "docdb_subnet_groups" {
  description = "DocDB subnet group 정의 map"
  type = map(object({
    name        = string
    description = string
    subnet_ids  = list(string)
  }))
  default = {}
}
