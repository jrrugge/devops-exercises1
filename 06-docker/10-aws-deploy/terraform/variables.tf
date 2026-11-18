variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "smartlead"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  type = map(object({
    cidr = string
    az   = string
    tier = string # public | app | db
  }))
  default = {
    public-a = { cidr = "10.0.0.0/24", az = "us-east-1a", tier = "public" }
    public-b = { cidr = "10.0.1.0/24", az = "us-east-1b", tier = "public" }
    app-a    = { cidr = "10.0.10.0/24", az = "us-east-1a", tier = "app" }
    app-b    = { cidr = "10.0.11.0/24", az = "us-east-1b", tier = "app" }
    db-a     = { cidr = "10.0.20.0/24", az = "us-east-1a", tier = "db" }
    db-b     = { cidr = "10.0.21.0/24", az = "us-east-1b", tier = "db" }
  }
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}