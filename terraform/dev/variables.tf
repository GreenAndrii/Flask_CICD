variable "region" {
  default = "eu-central-1"
}

variable "key_name" {
  description = "Name of key pair"
  default     = "devops-eu-central-1"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "ubuntu"
}
