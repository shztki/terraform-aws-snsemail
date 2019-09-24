variable "region" {
  type        = "string"
  description = "Specify AWS Region."
}

variable "topic_name" {
  type        = "string"
  description = "A friendly name for SNS topic."
}

variable "topic_display_name" {
  type        = "string"
  description = "Display name for the SNS topic."
}

variable "emails" {
  type        = "list"
  description = "Email address List."
}

variable "protocol" {
  type        = "string"
  description = "This module create only Email protocol Subscription."
  default     = "email"
}
