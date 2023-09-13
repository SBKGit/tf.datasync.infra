import boto3



def handler(event, context):

    # Initialize the Boto3 Auto Scaling and EC2 clients
    autoscaling_client = boto3.client('autoscaling')
    ec2_client = boto3.client('ec2')

    # Define the name of your Auto Scaling group
    auto_scaling_group_name = 'YourAutoScalingGroupName'

    # Suspend health checks for the Auto Scaling group
    response = autoscaling_client.suspend_processes(
        AutoScalingGroupName=auto_scaling_group_name,
        ScalingProcesses=['HealthCheck']
    )

    if response['ResponseMetadata']['HTTPStatusCode'] == 200:
        print(f"Health checks suspended for Auto Scaling group: {auto_scaling_group_name}")

    # Describe instances in the Auto Scaling group
    response = autoscaling_client.describe_auto_scaling_groups(
        AutoScalingGroupNames=[auto_scaling_group_name]
    )

    # Get the instance IDs in the Auto Scaling group
    instance_ids = [instance['InstanceId'] for instance in response['AutoScalingGroups'][0]['Instances']]

    # Terminate (stop) the EC2 instances in the Auto Scaling group
    if instance_ids:
        ec2_client.stop_instances(InstanceIds=instance_ids)
        print(f"Terminating instances in Auto Scaling group: {auto_scaling_group_name}")
    else:
        print(f"No instances found in Auto Scaling group: {auto_scaling_group_name}")
