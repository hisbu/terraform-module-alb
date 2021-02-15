resource "aws_lb" "this" {
  name               = var.ALB_NAME
  internal           = var.ALB_SCHEME
  load_balancer_type = var.ALB_TYPE
  security_groups    = var.ALB_SG
  subnets            = var.SUBNETS

  enable_deletion_protection = var.ALB_DELETE_PROTEC
}

resource "aws_lb_target_group" "this" {
  name     = var.TG_NAME
  port     = var.TG_PORT
  protocol = var.TG_POROTO
  vpc_id   = var.VPC_ID
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.ALB_PORT
  protocol          = var.ALB_PROTO

  default_action {
    type             = var.LISTENER_TYPE
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group_attachment" "vm1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.TG_INSTANCE_ID[0]
  port             = var.INSTANCE_PORT
}

resource "aws_lb_target_group_attachment" "vm2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.TG_INSTANCE_ID[1]
  port             = var.INSTANCE_PORT
}