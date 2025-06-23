variable "security_groups" {
  description = "Security Group 정의 map"
  type = map(object({
    name        = string
    description = string
    vpc_id      = string
    tags        = optional(map(string))
    ingress     = optional(list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
      description     = optional(string)
    })), [])
    egress      = optional(list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string))
      ipv6_cidr_blocks = optional(list(string))
      description      = optional(string)
    })), [])
  }))
}
