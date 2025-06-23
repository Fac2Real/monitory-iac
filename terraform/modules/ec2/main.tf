resource "aws_instance" "jenkins_free" {
  ami                    = var.jenkins_free.ami
  instance_type          = var.jenkins_free.instance_type
  key_name               = var.jenkins_free.key_name
  availability_zone      = var.jenkins_free.availability_zone
  tenancy                = var.jenkins_free.tenancy
  subnet_id              = var.jenkins_free.subnet_id
  ebs_optimized          = var.jenkins_free.ebs_optimized
  vpc_security_group_ids = var.jenkins_free.vpc_security_group_ids
  source_dest_check      = var.jenkins_free.source_dest_check
  root_block_device {
    volume_size           = var.jenkins_free.root_block_device.volume_size
    volume_type           = var.jenkins_free.root_block_device.volume_type
    delete_on_termination = var.jenkins_free.root_block_device.delete_on_termination
  }
  iam_instance_profile = var.jenkins_free.iam_instance_profile
  tags                 = var.jenkins_free.tags
}

resource "aws_network_interface" "eni" {
  for_each          = var.enis
  description       = each.value.description
  private_ips       = each.value.private_ips
  subnet_id         = each.value.subnet_id
  source_dest_check = each.value.source_dest_check
  security_groups   = each.value.security_groups
}

resource "aws_network_interface_attachment" "eni_attach" {
  for_each             = var.eni_attachments
  network_interface_id = each.value.network_interface_id
  device_index         = each.value.device_index
  instance_id          = each.value.instance_id
}
