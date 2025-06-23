variable "iam_roles" {
  description = "IAM Role definitions"
  type = map(object({
    name                 = string
    path                 = optional(string)
    assume_role_policy   = string
    max_session_duration = optional(number)
    tags                 = optional(map(string))
  }))
}

variable "iam_policies" {
  description = "IAM Policy definitions"
  type = map(object({
    name   = string
    path   = optional(string)
    policy = string
  }))
}

variable "iam_role_policies" {
  description = "IAM Role inline policy definitions"
  type = map(object({
    name   = string
    role   = string
    policy = string
  }))
}

variable "iam_service_linked_roles" {
  description = "IAM Service Linked Role definitions"
  type = map(object({
    aws_service_name = string
    description      = optional(string)
  }))
}

variable "iam_instance_profiles" {
  description = "IAM Instance Profile definitions"
  type = map(object({
    name  = string
    path  = optional(string)
    roles = list(string)
  }))
}
