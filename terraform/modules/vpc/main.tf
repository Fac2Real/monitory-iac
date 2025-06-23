resource "aws_vpc" "EC2VPC" {
    cidr_block = "172.31.0.0/20"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "jenkins-vpc"
    }
}

resource "aws_vpc" "EC2VPC2" {
    cidr_block = "172.31.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "monitory-vpc"
    }
}

resource "aws_subnet" "EC2Subnet" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "172.31.0.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet2" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "172.31.32.0/20"
    vpc_id = "${aws_vpc.EC2VPC2.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet3" {
    availability_zone = "ap-northeast-2c"
    cidr_block = "172.31.48.0/20"
    vpc_id = "${aws_vpc.EC2VPC2.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet4" {
    availability_zone = "ap-northeast-2c"
    cidr_block = "172.31.16.0/20"
    vpc_id = "${aws_vpc.EC2VPC2.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet5" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "${aws_vpc.EC2VPC.cidr_block}"
    vpc_id = "${aws_vpc.EC2VPC2.id}"
    map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "EC2InternetGateway" {
    tags = {
        Name = "jenkins-igw"
    }
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_internet_gateway" "EC2InternetGateway2" {
    tags = {
        Name = "monitory-igw"
    }
    vpc_id = "${aws_vpc.EC2VPC2.id}"
}

resource "aws_eip" "EC2EIP" {
    vpc = true
    instance = "i-0ff6488abd018a5b9"
}

resource "aws_eip_association" "EC2EIPAssociation" {
    allocation_id = "eipalloc-079d817da75478901"
    instance_id = "i-0ff6488abd018a5b9"
    network_interface_id = "eni-0131cc60c1fdef0ed"
    private_ip_address = "172.31.0.240"
}

resource "aws_eip" "EC2EIP2" {
    vpc = true
    instance = "i-0657161b954e3eb4e"
}

resource "aws_eip_association" "EC2EIPAssociation2" {
    allocation_id = "eipalloc-045c90b5eafd0b1b4"
    instance_id = "i-0657161b954e3eb4e"
    network_interface_id = "eni-09ea18c2053449a41"
    private_ip_address = "172.31.14.16"
}

resource "aws_vpc_dhcp_options" "EC2DHCPOptions" {
    domain_name = "ap-northeast-2.compute.internal"
    tags = {}
}

resource "aws_vpc_dhcp_options_association" "EC2VPCDHCPOptionsAssociation" {
    dhcp_options_id = "dopt-0fc10cbab02157674"
    vpc_id = "${aws_vpc.EC2VPC2.id}"
}

resource "aws_vpc_dhcp_options_association" "EC2VPCDHCPOptionsAssociation2" {
    dhcp_options_id = "dopt-0fc10cbab02157674"
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_route_table" "EC2RouteTable" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        Name = "jenkins-public"
    }
}

resource "aws_route_table" "EC2RouteTable2" {
    vpc_id = "${aws_vpc.EC2VPC2.id}"
    tags = {
        Name = "public-table"
    }
}

resource "aws_route_table" "EC2RouteTable3" {
    vpc_id = "${aws_vpc.EC2VPC2.id}"
    tags = {
        Name = "private-table"
    }
}

resource "aws_route" "EC2Route" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "igw-055ea8dba8c5ee707"
    route_table_id = "rtb-0228081f52f90a105"
}

resource "aws_route" "EC2Route2" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0c2db9f23ba75c5f8"
    route_table_id = "rtb-0b35d4feadc95d9da"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation" {
    route_table_id = "rtb-0228081f52f90a105"
    subnet_id = "subnet-0eb876da7e1ce441f"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation2" {
    route_table_id = "rtb-0b35d4feadc95d9da"
    subnet_id = "subnet-0a6b14d60781586a9"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation3" {
    route_table_id = "rtb-0b35d4feadc95d9da"
    subnet_id = "subnet-06d0bf134594edce9"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation4" {
    route_table_id = "rtb-0e4522aefd5468423"
    subnet_id = "subnet-0ec55f30969f625c2"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation5" {
    route_table_id = "rtb-0e4522aefd5468423"
    subnet_id = "subnet-0c6e3e5c2f70c6d15"
}
