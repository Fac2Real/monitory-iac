variable "jenkins_free" {
  type = object({
    ami                    = string
    instance_type          = string
    key_name               = string
    availability_zone      = string
    tenancy                = string
    subnet_id              = string
    ebs_optimized          = bool
    vpc_security_group_ids = list(string)
    source_dest_check      = bool
    root_block_device = object({
      volume_size           = number
      volume_type           = string
      delete_on_termination = bool
    })
    iam_instance_profile = string
    tags                 = map(string)
  })
}

variable "enis" {
  type = map(object({
    description       = string
    private_ips       = list(string)
    subnet_id         = string
    source_dest_check = bool
    security_groups   = list(string)
  }))
}

variable "eni_attachments" {
  type = map(object({
    network_interface_id = string
    device_index         = number
    instance_id          = string
  }))
}
