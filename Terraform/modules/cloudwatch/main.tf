
resource "aws_cloudwatch_metric_alarm" "cpu_too_high" {
  alarm_name          = "cpu_too_high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    InstanceId = var.instance_id
  }
}
