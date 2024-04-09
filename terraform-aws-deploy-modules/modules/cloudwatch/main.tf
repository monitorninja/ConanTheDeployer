# Description: This file contains the configuration for the cloudwatch metrics alarms
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/cloudwatch/main.tf

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "frankaaronsmith-app-server-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"  # 2 minutes
  statistic           = "Average"
  threshold           = "80" # Alarm if CPU usage >= 80%

  dimensions = {
    InstanceId = aws_instance.frankaaronsmith-app-server.id
  }
}
