variable "ami" {
  type = string
  description = "VMImage"
}

variable "instance_type" {
  type = string
  description = "Resources Configuration"
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


variable "publicsubnet" {
  type = list(string)
    description = "Subnets"
    #default = "Naqel-IT"
}



variable "ec2_key_pair_path" {
  type        = string
  description = "Location of keypair file"
  default     = "C:\\Users\\20952reddy\\" # Update the path to your desired location
}

variable "vpc_security_group_ids" {
  type = list(string)
  description = "vpc_security_group_ids"
    #default = "Naqel-IT"
}


variable "os_version" {
  type = string
  description = "Ubuntu or Linux or Mac os versions"
}

variable "virtualization_type" {
  type = string
  description = "virtualization_type of your machine"
  default = "hvm"
}

variable "ami_name" {
  description = "The name filter for the AMI"
  type        = string
}