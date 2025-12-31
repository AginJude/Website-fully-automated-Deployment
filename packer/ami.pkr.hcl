packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

source "amazon-ebs" "web-ami" {
  region        = "eu-west-3"
  instance_type = "t3.micro"
  source_ami    = "ami-078abd88811000d7e"
  ssh_username  = "ec2-user"
  ami_name      = "web-ami-{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.web-ami"]

  provisioner "file" {
    source      = "../website-file"
    destination = "/tmp/website-file"
  }

  provisioner "shell" {
    script = "install.sh"
  }
}

