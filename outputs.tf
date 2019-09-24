output "sns_topic_id" {
  description = "SNS topic id"
  value       = "${aws_sns_topic.this.id}"
}

output "sns_topic_arn" {
  description = "SNS topic ARN"
  value       = "${aws_sns_topic.this.arn}"
}
