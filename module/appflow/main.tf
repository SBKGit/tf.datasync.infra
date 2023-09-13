# Create an AppFlow Connector Profile
resource "aws_appflow_connector_profile" "connector_profile" {
  name = "${var.name}-connector"
  connector_type         = var.profile_Source_connection_type
  connection_mode        = var.connection_mode

connector_profile_config {
  connector_profile_properties {
  dynamics_365 {
    instance_url      = var.dynamics_instance_url # Replace with your Dynamics 365 instance URL
    organization_name = var.organization_name     # Replace with your organization name
  }
  }

  connector_profile_credentials  {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}
}

# Create an AppFlow Flow
resource "aws_appflow_flow" "app_flow" {
  name    = "${var.name}-appflow"
  description  = "AppFlow integration with Dynamics 365"
  trigger_type = var.trigger_type # You can change this to another trigger type

  source_flow_config {
    connector_type         = var.profile_Source_connection_type # Assuming you are importing data into Salesforce
    connector_profile_name = aws_appflow_connector_profile.connector_profile.connector_profile_name
    # Define other source-specific configurations here
  }

  destination_flow_config {
    type = "S3"
    s3_destination_properties {
      bucket_name             = var.destination_bucket_name
      bucket_prefix           = var.destination_bucket_prefix
      s3_output_format_config = var.destination_output_format
    }
  }

  tags = {
    Name        = "${var.name}-appflow"
    Environment = var.env
  }

}

