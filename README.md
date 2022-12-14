# terraform-aws-ecs-ec2-example

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.7 |
| aws | 4.27.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 4.27.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/acm_certificate) | resource |
| [aws_alb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/alb_listener) | resource |
| [aws_alb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/alb_target_group) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/ecs_task_definition) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/4.27.0/docs/resources/lb) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_id | n/a | `string` | n/a | yes |
| aws\_region | n/a | `string` | n/a | yes |
| cpu | ECS CPU | `number` | n/a | yes |
| domain\_name | n/a | `string` | n/a | yes |
| ecs\_cluster\_id | n/a | `string` | n/a | yes |
| health\_check\_path | n/a | `string` | `"/"` | no |
| image\_uri | ECS image uri | `string` | n/a | yes |
| memory | ECS memory | `number` | n/a | yes |
| service\_name | ECS service name | `string` | n/a | yes |
| subnet\_id | n/a | `list(string)` | n/a | yes |
| task\_role | ECS task role arn | `string` | n/a | yes |
| vpc\_id | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->
