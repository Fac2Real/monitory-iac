// modules/jenkins/eip.tf

# 1. 기존 EIP 조회
data "aws_eip" "jenkins_ip" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-ip"]
  }
}

# 2. EC2 인스턴스에 EIP 연결
resource "aws_eip_association" "jenkins_assoc" {
  instance_id   = aws_instance.jenkins_controller.id
  allocation_id = data.aws_eip.jenkins_ip.id
}
