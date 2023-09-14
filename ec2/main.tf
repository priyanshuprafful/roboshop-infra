data "aws_ami" "ami" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

resource "aws_instance" "ec2"  {
  ami = data.aws_ami.ami.image_id
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = var.component
  }
  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      user = "centos"
      password = "DevOps321"
    }

    inline = [
      "git clone https://github.com/priyanshuprafful/roboshop_shell.git",
      "cd roboshop_shell",
      "sudo bash ${var.component}.sh"
    ]

  }
}


resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"


  ingress {
    description      = "ALL"
    from_port        = 0 # 0 is for everyone and 22 is for ssh and 80 is for http like that
    to_port          = 0
    protocol         = "-1" # instead of tcp we give -1 which means allow all
    cidr_blocks      = ["0.0.0.0/0"]
    # so this becomes allow-all kind of a security group .
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "Z05260162XS3U1UPP64CC"
  name    = "${var.component}-dev.saraldevops.online" # here we used dollar as we are adding full domain name
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

variable "component" {}
variable "instance_type" {}

variable "env" {
  default = "dev"
}