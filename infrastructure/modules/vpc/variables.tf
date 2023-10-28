variable "vpc_cidr_block" {
  type = list(string)
  description = "cidr block range for vpc"
  default = []
}

variable "public_subnets" {
  type = list(string)
  description = "cidr block range for vpc"
  default = []
}

variable "private_subnets" {
  type = list(string)
  description = "cidr block range for vpc"
  default = []
}

variable "azs" {
  type = list(string)
  description = "cidr block range for vpc"
  default = []
}

variable "environment" {
    type = string
    description = "project environment"
    default = "dev"
  
}

variable "projectname" {
    type = string
    description = "project name"
    default = "Naqel-IT"
  
}

variable "port" {
    type = list(number)
    description = "project name"
    default = []
  
}

variable "create_internet_gateway" {
  description = "Set to true to create an internet gateway, false to ignore it."
  type        = bool
  default     = false
}
/*
variable "create_internet_gateway_attachment" {
  description = "Set to true to create an internet gateway attachment, false to ignore it."
  type        = bool
  default     = false
}
*/

variable "create_route_table" {
  description = "Set to true to create a route table, false to ignore it."
  type        = bool
  default     = false
}

variable "create_route" {
  description = "Set to true to create a route, false to ignore it."
  type        = bool
  default     = false
}


variable "create_security_group" {
  description = "Whether to create the AWS security group"
  type        = bool
  default     = false
}
