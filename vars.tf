
variable "region" {
  description = "default region"
}

variable "environment" {
  description = "The Deployment environment"
}

variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnet1_cidr" {
  description = "The CIDR block for the public subnet"
}

variable "public_subnet2_cidr" {
  description = "The CIDR block for the public subnet"
}

variable "private_subnet1_cidr" {
  description = "The CIDR block for the private subnet"
}

variable "private_subnet2_cidr" {
  description = "The CIDR block for the private subnet"
}


variable "db_name"{
  description = "The database name"
}
variable "db_pass"{
    description = "The database password"
}

variable "db_user"{
  description = "The database user"
  
}
