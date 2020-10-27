output "load_balancer_dns" {
  value = aws_lb.niginx-alb.dns_name
}