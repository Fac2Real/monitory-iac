variable "vpcs" {
  description = "VPC 정의 map"
  type = map(object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    instance_tenancy     = string
    tags                 = map(string)
  }))
}

variable "subnets" {
  description = "Subnet 정의 map"
  type = map(object({
    availability_zone      = string
    cidr_block             = string
    vpc_ref                = string  # vpcs map의 key
    map_public_ip_on_launch = bool
  }))
}

variable "internet_gateways" {
  description = "IGW 정의 map"
  type = map(object({
    vpc_ref = string
    tags    = map(string)
  }))
}

variable "eips" {
  description = "EIP 정의 map"
  type = map(object({
    instance = string
  }))
  default = {}
}

variable "eip_associations" {
  description = "EIP Association 정의 map"
  type = map(object({
    allocation_id        = string
    instance_id          = string
    network_interface_id = string
    private_ip_address   = string
  }))
  default = {}
}

variable "dhcp_options" {
  description = "DHCP Options 정의 map"
  type = map(object({
    domain_name = string
    tags        = map(string)
  }))
  default = {}
}

variable "dhcp_options_associations" {
  description = "DHCP Options Association 정의 map"
  type = map(object({
    dhcp_options_id = string
    vpc_ref         = string
  }))
  default = {}
}

variable "route_tables" {
  description = "Route Table 정의 map"
  type = map(object({
    vpc_ref = string
    tags    = map(string)
  }))
}

variable "routes" {
  description = "Route 정의 map"
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
    route_table_id         = string
  }))
  default = {}
}

variable "route_table_associations" {
  description = "Route Table Association 정의 map"
  type = map(object({
    route_table_id = string
    subnet_id      = string
  }))
  default = {}
}
