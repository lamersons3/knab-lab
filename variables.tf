variable "region" {
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.240.0.0/16"
}

variable "private_subnet_cidr" {
  type        = string
  default     = "10.240.100.0/24"
}
variable "public_subnet_cidr" {
  type        = string
  default     = "10.240.101.0/24"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ec2_private_ip" {
  type        = string
  default     = "10.240.100.4"
}

variable "ssl_cert_arn" {
  type        = string
  default     = "arn:aws:acm:eu-central-1:864899850759:certificate/8b8560d2-d5d9-4a53-a145-73064a619bc7"
}

variable "tags" {
  type        = map(string)
  default     = {
    Project = "knab-lab"
    Owner   = "mikez"
  }
}
