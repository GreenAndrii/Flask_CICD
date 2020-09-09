provider "aws" {
  region = var.region

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["*ubuntu-focal-20.04-amd64-server-*"] # or "*ubuntu-bionic-18.04-amd64-server-*"
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "flask_dev"
  instance_count = 1
  # ami                  = "ami-04932daa2567651e7" # Ubuntu
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids = ["sg-021bfd8e5a5d21433"]

  # user_data = "curl https://ipv4.cloudns.net/api/dynamicURL/?q=MjkwMTQ1MDoyMDk4MTc1NzQ6MTE1ZDg4NDVlYTYzYTU4NmU4NzI5MDMxMjBiNmU5NjU1ZGY1YmI5ZDA5NGQ1OTM5NTA3NjZiN2FlMjlkNWRlOA"


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# generate Ansible hosts file
resource "local_file" "hosts" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      flask_dev = module.ec2.public_ip
    }
  )
  filename = "../../ansible/hosts"
}

