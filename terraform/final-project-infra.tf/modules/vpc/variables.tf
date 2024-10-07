variable "cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_id" {
  description = "The ID of the VPC where RDS will be deployed"
  type        = string
}
