variable "things" {
  description = "IoT Things 정의"
  type = map(object({
    name       = string
    attributes = optional(map(string), {})
  }))
}

variable "certificates" {
  description = "IoT Certificates 정의"
  type = map(object({
    active = bool
    csr    = string
  }))
}

variable "thing_principal_attachments" {
  description = "Thing-Principal Attachments"
  type = map(object({
    thing     = string
    principal = string
  }))
}

variable "policies" {
  description = "IoT Policies"
  type = map(object({
    name   = string
    policy = string
  }))
}

variable "policy_attachments" {
  description = "Policy Attachments"
  type = map(object({
    policy = string
    target = string
  }))
}
