// 1) AMI 이름으로 ID를 조회하는 데이터 소스
data "aws_ami" "jenkins_controller" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = [var.controller_ami_name]
  }
}

// 2) EC2 리소스에 조회된 ID를 할당
resource "aws_instance" "jenkins_controller" {
  ami                    = data.aws_ami.jenkins_controller.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins_controller.name

  tags = {
    Name = "jenkins-controller"
  }
}

output "controller_public_ip" {
  value = aws_instance.jenkins_controller.public_ip
}
