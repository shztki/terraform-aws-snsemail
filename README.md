# terraform-aws-snsemail

* SNS topic とそれに紐づくサブスクリプション(Emailプロトコル)を作成する。
* 指定したメールアドレスに `AWS Notification - Subscription Confirmation` メールが届くので、承認すると利用可能となる。
* **承認した際に表示されるサイト内にある「click here to unsubscribe.」リンクをクリックすると、サブスクリプションが解除されてしまうので、ユーザーへの案内等要注意。**
* destroy時、Subscription は削除されないため、別途削除対応が必要。
```
■ 確認コマンド例
aws sns list-subscriptions

■ 削除コマンド
aws sns unsubscribe --subscription-arn YOUR_SUBSCRIPTION_ARN
```

## Usage:
```
module "sns_myself" {
  region             = "ap-northeast-1"
  source             = "git::https://github.com/shztki/terraform-aws-snsemail.git?ref=1.0.0"
  topic_name         = "notification-myself"
  topic_display_name = "notification-myself"
  emails             = ["myself@exapmle.com", "myself2@example.com"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| emails | Email address List. | list | n/a | yes |
| protocol | This module create only Email protocol Subscription. | string | `"email"` | no |
| region | Specify AWS Region. | string | n/a | yes |
| topic\_display\_name | Display name for the SNS topic. | string | n/a | yes |
| topic\_name | A friendly name for SNS topic. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sns\_topic\_arn | SNS topic ARN |
| sns\_topic\_id | SNS topic id |

