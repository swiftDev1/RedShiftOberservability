resource "aws_sns_topic" "redshift_alarms" {
  name = "redshift_moitoring"
}

resource "aws_sns_topic_subscription" "redshift_alarms_subscription" {

  for_each = toset(var.email_endpoints)

  topic_arn = aws_sns_topic.redshift_alarms.arn
  protocol  = "email"
  endpoint  = each.key
}

resource "aws_cloudwatch_metric_alarm" "redshift_cpuutilization_alarm" {
  alarm_name          = "jp-RedShift CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2 # the consecutive number of periods the speicified conditions must be met before the alarm is triggered
  metric_name         = "CPUUtilization"
  namespace           = "AWS/Redshift"
  period              = 300 # length of time in seconds over which to aggregate the metric data
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "## The redshift cluster ${var.redshift_cluster_identifier}'s CPU Utilization is over 80%"
  alarm_actions       = [aws_sns_topic.redshift_alarms.arn]
  actions_enabled = true
  dimensions = {
    ClusterIdentifier = "redshift-cluster-1"
    }
  datapoints_to_alarm = 1
}






resource "aws_cloudwatch_metric_alarm" "redshift_health_status_alarm" {
  alarm_name          = "jp-RedShift HealthStatus"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2 # the consecutive number of periods the speicified conditions must be met before the alarm is triggered
  metric_name         = "HealthStatus"
  namespace           = "AWS/Redshift"
  period              = 300 # length of time in seconds over which to aggregate the metric data
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "The redshift cluster ${var.redshift_cluster_identifier} is Unhealthy"
  alarm_actions       = [aws_sns_topic.redshift_alarms.arn]
  dimensions = {
    ClusterIdentifier = "redshift-cluster-1"
    }

}

resource "aws_cloudwatch_metric_alarm" "redshift_diskspace_alarm" {
  alarm_name          = "jp-RedShift PercentageDiskSpaceUsed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1 # the consecutive number of periods the speicified conditions must be met before the alarm is triggered
  metric_name         = "PercentageDiskSpaceUsed"
  namespace           = "AWS/Redshift"
  period              = 300 # length of time in seconds over which to aggregate the metric data
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "The redshift cluster ${var.redshift_cluster_identifier}'s PercentageDiskSpaceUsed is over 80%"
  alarm_actions       = [aws_sns_topic.redshift_alarms.arn]
  dimensions = {
    ClusterIdentifier = "redshift-cluster-1"
    }


}