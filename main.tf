#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "this" {
  retention_in_days = 14
  name              = "/aws/ecs/${var.service_name}"
}


resource "aws_ecs_task_definition" "this" {
  family             = var.service_name
  cpu                = var.cpu
  memory             = var.memory
  execution_role_arn = var.task_role
  task_role_arn      = var.task_role

  container_definitions = jsonencode(
    [
      {
        name        = var.service_name
        image       = var.image_uri
        essential   = true
        environment = []

        portMappings = [
          {
            protocol      = "tcp"
            containerPort = 80
            hostPort      = 80
          }
        ]
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = aws_cloudwatch_log_group.this.name
            awslogs-region        = var.aws_region
            awslogs-stream-prefix = "ecs"
          }
        }
      }
    ]
  )
}


resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1

  # https://github.com/hashicorp/terraform/issues/26950
  depends_on = [aws_lb.this, aws_alb_target_group.this]

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.arn
    container_name   = var.service_name
    container_port   = 80
  }
}
