resource "aws_cloudwatch_dashboard" "redshift_dashboard" {
  dashboard_name = "RedShiftDashboard"

  dashboard_body = jsonencode({
    widgets = [
# TEXT LABEL FOR THE DASHBOARD
    {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1

        properties = {
          markdown = "## RedShift Cluster Metrics"
        }
      },

      #CPU UTILIZATION WIDGET
      {
        type   = "metric"
        x      = 0
        y      = 1
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "CPUUtilization", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "CPU Utilization"
        }
      },

      # DATABASE CONNECTIONS WIDGET
      {
        type   = "metric"
        x      = 12
        y      = 1
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "DatabaseConnections", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "Database Connections"
        }
      },

      #HEALTH STATUS AND MAINTENANCE MODE WIDGET

      {
        type   = "metric"
        x      = 0
        y      = 7
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "HealthStatus", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "MaintenanceMode", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "Cluster Health Status"
        }
      },

# NETWORK RECEIVE THROUGHPUT AND NETWORK TRANSMIT THROUGHPUT WIDGET
      {
        type   = "metric"
        x      = 12
        y      = 7
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "NetworkReceiveThroughput", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "NetworkTransmitThroughput", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "Network Throughput"
        }
      },

    # PERCENTAGE DISK SPACE AND QUOTA USED WIDGET

      {
        type   = "metric"
        x      = 0
        y      = 13
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "PercentageDiskSpaceUsed", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "PercentageQuotaUsed", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "Percentage Disk Space and Quota Used"
        }
      },

    # QUERIES WIDGEET
      {
        type   = "metric"
        x      = 12
        y      = 13
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "QueriesCompletedPerSecond", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "QueryDuration", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "QueryRuntimeBreakdown", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "QueryDuration, QueryRuntimeBreakdown & QueriesCompleted"
        }
      },

# READ IOPS, LATENCY AND THROUGHPUT WIDGET
      {
        type   = "metric"
        x      = 0
        y      = 19
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "ReadIOPS", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "ReadLatency", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "ReadThroughput", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "ReadIOPS, Latency & Throughput"
        }
      },

# WRITE IOPS, LATENCY AND THROUGHPUT WIDGET
      {
        type   = "metric"
        x      = 12
        y      = 19
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "WriteIOPS", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "WriteLatency", "ClusterIdentifier", var.redshift_cluster_identifier],
            ["AWS/Redshift", "WriteThroughput", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "WriteIOPS, Latency & Throughput"
        }
      },

# TOTAL TABLE COUNT WIDGET
      {
        type   = "metric"
        x      = 0
        y      = 25
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Redshift", "TotalTableCount", "ClusterIdentifier", var.redshift_cluster_identifier]
          ]
          view: "timeSeries",
          stacked: false, 
          region = var.region
          title  = "Total Table Count"
        }
      }

    ]
  })
}