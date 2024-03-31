variable "resource_tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources"
}
