provider "aws" {
  region = "eu-central-1"

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "flask_dev"
  instance_count = 1

  ami           = "ami-0c115dbd34c69a004"
  instance_type = "t2.micro"
  key_name      = "devops-eu-central-1"
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]

  user_data = "curl https://ipv4.cloudns.net/api/dynamicURL/?q=MjkwMTQ1MDoyMDk4MTc1NzQ6MTE1ZDg4NDVlYTYzYTU4NmU4NzI5MDMxMjBiNmU5NjU1ZGY1YmI5ZDA5NGQ1OTM5NTA3NjZiN2FlMjlkNWRlOA"


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
