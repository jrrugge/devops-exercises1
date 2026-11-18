variable "region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "project" {
  type        = string
  description = "Name prefix for every resource"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block, for example 10.0.0.0/16."
  }
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "db_multi_az" {
  type        = bool
  description = "Run a standby database in the second AZ (not free tier)"
}

variable "db_allocated_storage" {
  type        = number
  description = "RDS storage in GiB"
}

variable "app_instance_type" {
  type        = string
  description = "EC2 instance type for the app"
}

variable "app_image_tag" {
  type        = string
  description = "Tag of the smartlead-app image in ECR to run"
}