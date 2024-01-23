resource "aws_sns_topic" "redshift_alarms" {
  name = "redshift_observability"
}

resource "aws_sns_topic_subscription" "redshift_alarms_subscription" {

  for_each = toset(var.email_endpoints)

  topic_arn = aws_sns_topic.redshift_alarms.arn
  protocol  = "email"
  endpoint  = each.key
}

resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name          = "RedShift CPU Utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2 # the consecutive number of periods the speicified conditions must be met before the alarm is triggered
  metric_name         = "CPUUtilization"
  namespace           = "AWS/Redshift"
  period              = 120 # length of time in seconds over which to aggregate the metric data
  statistic           = "Average"
  threshold           = 5
  alarm_description   = "The redshift cluster ${var.redshift_cluster_identifier}'s CPU Utilization is over 80%"
  alarm_actions       = [aws_sns_topic.redshift_alarms.arn]

}