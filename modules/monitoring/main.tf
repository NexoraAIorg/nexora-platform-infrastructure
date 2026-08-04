#############################################
# CloudWatch Log Group
#############################################

resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/${local.name}"

  retention_in_days = 30

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-logs"
    }
  )
}

#############################################
# SNS Topic
#############################################

resource "aws_sns_topic" "alerts" {

  name = "${local.name}-alerts"

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-alerts"
    }
  )
}

#############################################
# CPU Alarm
#############################################

resource "aws_cloudwatch_metric_alarm" "high_cpu" {

  alarm_name = "${local.name}-high-cpu"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 300

  statistic = "Average"

  threshold = 80

  alarm_description = "High CPU Utilization"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
}

#############################################
# CloudWatch Dashboard
#############################################

resource "aws_cloudwatch_dashboard" "main" {

  dashboard_name = "${local.name}-dashboard"

  dashboard_body = jsonencode({

    widgets = []

  })

}