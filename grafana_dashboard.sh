#!/bin/bash

GRAFANA_ENDPOINT=$1
IAM_ROLE_ARN=$2
ALB_NAME=$3
ECS_SERVICE_NAME=$4
GRAFANA_API_KEY=$(aws grafana create-workspace-api-key --workspace-id $GRAFANA_WORKSPACE_ID --key-name "grafana-api-key" --key-role ADMIN --seconds-to-live 86400 --query 'key' --output text)

DASHBOARD_JSON=$(cat <<EOF
{
  "dashboard": {
    "id": null,
    "title": "Golden Signals Dashboard",
    "tags": ["templated"],
    "timezone": "browser",
    "schemaVersion": 16,
    "version": 0,
    "panels": [
      {
        "title": "Latency",
        "type": "graph",
        "datasource": "CloudWatch",
        "targets": [
          {
            "region": "ap-southeast-2",
            "namespace": "AWS/ApplicationELB",
            "metricName": "TargetResponseTime",
            "statistics": ["Average"],
            "dimensions": {
              "LoadBalancer": "$ALB_NAME"
            }
          }
        ]
      },
      {
        "title": "Traffic",
        "type": "graph",
        "datasource": "CloudWatch",
        "targets": [
          {
            "region": "ap-southeast-2",
            "namespace": "AWS/ECS",
            "metricName": "NetworkPacketsIn",
            "statistics": ["Sum"],
            "dimensions": {
              "ClusterName": "$GRAFANA_WORKSPACE_ID",
              "ServiceName": "$ECS_SERVICE_NAME"
            }
          }
        ]
      },
      {
        "title": "Errors",
        "type": "graph",
        "datasource": "CloudWatch",
        "targets": [
          {
            "region": "ap-southeast-2",
            "namespace": "AWS/ApplicationELB",
            "metricName": "HTTPCode_Target_5XX_Count",
            "statistics": ["Sum"],
            "dimensions": {
              "LoadBalancer": "$ALB_NAME"
            }
          }
        ]
      },
      {
        "title": "Saturation",
        "type": "graph",
        "datasource": "CloudWatch",
        "targets": [
          {
            "region": "ap-southeast-2",
            "namespace": "AWS/ECS",
            "metricName": "CPUUtilization",
            "statistics": ["Average"],
            "dimensions": {
              "ClusterName": "$GRAFANA_WORKSPACE_ID",
              "ServiceName": "$ECS_SERVICE_NAME"
            }
          }
        ]
      }
    ]
  },
  "folderId": 0,
  "overwrite": true
}
EOF
)

curl -X POST "$GRAFANA_ENDPOINT/api/dashboards/db" \
  -H "Authorization: Bearer $GRAFANA_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$DASHBOARD_JSON"