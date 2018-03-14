variable "access_key" {
  default = "ACCESS_KEY"
}

variable "secret_key" {
  default = "SECRET_KEY"
}

variable "region" {
  default = "eu-west-2"
}

variable "alb_name" {
  default = "my-alb"
}

variable "alb_subnets" {
  default = "subnet-6b412a10,subnet-cd800780"
}

variable "internal_alb" {
  default = "false"
}

variable "idle_timeout" {
  default = "10"
}

variable "alb_security_groups" {
  default = "my-alb-sg"
}

variable "alb_listener_port" {
  default = "5984"
}

variable "alb_listener_protocol" {
  default = "HTTP"
}

variable "priority" {
  default = "99"
}

variable "alb_path" {
  default = "/*"
}

variable "svc_port" {
  default = "5984"
}

variable "vpc_id" {
  default = "vpc-3cb9c055"
}

variable "svc_id" {
  default = "i-02904c8986b3365bd"
}

variable "target_group_name" {
  default = "my-alb-tg"
}

variable "target_group_sticky" {
  default = "false"
}

variable "target_group_path" {
  default = "/"
}

variable "target_group_port" {
  default = "5984"
}
