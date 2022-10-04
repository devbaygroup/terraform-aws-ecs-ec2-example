variable "aws_region" {
  type = string
}

variable "service_name" {
  type        = string
  description = "ECS service name"
}

variable "task_role" {
  type        = string
  description = "ECS task role arn"
}

variable "image_uri" {
  type        = string
  description = "ECS image uri"
}

variable "cpu" {
  type        = number
  description = "ECS CPU"
}

variable "memory" {
  type        = number
  description = "ECS memory"
}

variable "ecs_cluster_id" {
  type = string
}

variable "alb_id" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "domain_name" {
  type = string
}
