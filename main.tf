/**
 * ## Usage:
 * ```
 * module "sns_myself" {
 *   region             = "ap-northeast-1"
 *   source             = "git::https://github.com/shztki/terraform-aws-snsemail.git?ref=1.0.0"
 *   topic_name         = "notification-myself"
 *   topic_display_name = "notification-myself"
 *   emails             = ["myself@exapmle.com", "myself2@example.com"]
 * }
 * ```
 */

provider "aws" {
  region = "${var.region}"
  alias  = "specified"
}

resource "aws_sns_topic" "this" {
  provider     = "aws.specified"
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
        --region ${var.region}
    EOF
  }
}
