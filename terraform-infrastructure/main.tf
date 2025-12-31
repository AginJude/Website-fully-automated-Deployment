resource "aws_security_group" "auto_deploy_security_group" {
  name        = "new-security-group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-0c6401753f9993773"

  tags = {
    Name = "new-security-group-1"
  }
}

#Add rules into the security group

resource "aws_security_group_rule" "ssh-rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.auto_deploy_security_group.id
}


resource "aws_security_group_rule" "web-rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.auto_deploy_security_group.id
}


resource "aws_security_group_rule" "website-rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.auto_deploy_security_group.id
}


resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.auto_deploy_security_group.id
}


resource "aws_instance" "my-new-project" {
  ami                    = data.aws_ami.packer_ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.auto_deploy_security_group.id]

  tags = {
    Name = "ec2-from-packer-ami"
  }
}
