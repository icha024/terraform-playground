provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_alb" "alb" {
  name    = "${var.alb_name}"
  subnets = ["${split(",",var.alb_subnets)}"]

  #   security_groups = ["${split(",", var.alb_security_groups)}"]
  internal = "${var.internal_alb}"

  idle_timeout = "${var.idle_timeout}"

  tags {
    Name = "${var.alb_name}"
  }

  #   access_logs {
  #     bucket = "${var.s3_bucket}"
  #     prefix = "ELB-logs"
  #   }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "${var.alb_listener_port}"
  protocol          = "${var.alb_listener_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "listener_rule" {
  depends_on   = ["aws_alb_target_group.alb_target_group"]
  listener_arn = "${aws_alb_listener.alb_listener.arn}"
  priority     = "${var.priority}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"
  }

  condition {
    field  = "path-pattern"
    values = ["${var.alb_path}"]
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "${var.target_group_name}"
  port     = "${var.svc_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  tags {
    name = "${var.target_group_name}"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 1800
    enabled         = "${var.target_group_sticky}"
  }

  #   health_check {
  #     healthy_threshold   = 3
  #     unhealthy_threshold = 10
  #     timeout             = 5
  #     interval            = 10
  #     path                = "${var.target_group_path}"
  #     port                = "${var.target_group_port}"
  #   }
}

#Instance Attachment
resource "aws_alb_target_group_attachment" "svc_physical_external" {
  target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"

  #   target_id        = "${aws_instance.svc.id}"
  target_id = "${var.svc_id}"
  port      = "${var.target_group_port}"
}
