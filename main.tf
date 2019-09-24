/**
 * ## Usage:
 * ```
 * module "sns_myself" {
 *   source             = "git::https://github.com/shztki/terraform-aws-snsemail.git?ref=1.0.0"
 *   topic_name         = "notification-myself"
 *   topic_display_name = "notification-myself"
 *   emails             = ["myself@exapmle.com", "myself2@example.com"]
 * }
 * ```
 */

data "aws_region" "current" {}

resource "aws_sns_topic" "this" {
  name         = "${var.topic_name}"
  display_name = "${var.topic_display_name}"
}

resource "null_resource" "sns_subscribe" {
  depends_on = ["aws_sns_topic.this"]
  count      = "${length(var.emails)}"

  triggers = {
    sns_topic_arn = "${aws_sns_topic.this.arn}"
  }

  provisioner "local-exec" {
    command = <<EOF
      aws sns subscribe \
        --topic-arn ${aws_sns_topic.this.arn} \
        --protocol ${var.protocol} \
        --notification-endpoint ${element(var.emails, count.index)} \
        --region ${data.aws_region.current.name}
    EOF
  }
}
