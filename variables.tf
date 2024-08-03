variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "ap-southeast-2"
}

variable "ami_id" {
  description = "The AMI ID to use for the instances"
  type        = string
  default     = "ami-024ebc7de0fc64e44"
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "project"
}

variable "admin_user" {
  description = "Admin user for the first MongoDB instance"
  type        = string
  default     = "adminUser"
}

variable "admin_pass" {
  description = "Admin user password for the first MongoDB instance"
  type        = string
  default     = "adminPass"
}

variable "database2" {
  description = "Database name for the second MongoDB instance"
  type        = string
  default     = "database2"
}

variable "readwrite_user" {
  description = "User with read-write permissions for the second MongoDB instance"
  type        = string
  default     = "readWriteUser"
}

variable "readwrite_pass" {
  description = "Password for the read-write user for the second MongoDB instance"
  type        = string
  default     = "readWritePass"
}

variable "database3" {
  description = "Database name for the third MongoDB instance"
  type        = string
  default     = "database3"
}

variable "readonly_user" {
  description = "User with read-only permissions for the third MongoDB instance"
  type        = string
  default     = "readOnlyUser"
}

variable "readonly_pass" {
  description = "Password for the read-only user for the third MongoDB instance"
  type        = string
  default     = "readOnlyPass"
}
