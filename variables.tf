variable "region" {
  description = "aws region"
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "vpc cidr"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_1" {
  description = "public subnet cidr"
  default     = "10.0.3.0/24"
}

variable "public_subnet_cidr_2" {
  description = "public subnet cidr"
  default     = "10.0.4.0/24"
}


variable "private_subnet_cidr_1" {
  description = "private subnet cidr"
  default     = "10.0.5.0/24"
}

variable "private_subnet_cidr_2" {
  description = "private subnet cidr"
  default     = "10.0.6.0/24"
}