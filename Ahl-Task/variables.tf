variable "aws_region" {
  description = "eu-west-1"
  type        = string
}

variable "cloudtrail_name" {
  description = "CloudTrail for ahl task."
  type        = string
  default     = "Cloudtrail-for-ahl-task"
}

variable "cloudtrail_bucket_name" {
  description = "my-cloudtrail-bucket-for-ahl"
  type        = string
  default     = "my-cloudtrail-bucket-for-ahl"
}

variable "log_expiration_days" {
  description = "7"
  type        = number
  default     = 90
}

variable "cloudwatch_retention_days" {
  description = "7"
  type        = number
  default     = 90
}

variable "kms_key_id" {
  description = "45511d0a-97d0-4877-8854-a43b0ae0f13c"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

