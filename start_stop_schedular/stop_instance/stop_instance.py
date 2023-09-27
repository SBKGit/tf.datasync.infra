import boto3

def lambda_handler(event, context):
    # Specify your Auto Scaling Group names and the number of instances to stop
    asg_names = ["YourASGName1", "YourASGName2"]
    instances_to_stop = len(asg_names)  # Change this to the number of instances you want to stop
    
    # Initialize the AWS Auto Scaling and EC2 clients
    autoscaling = boto3.client('autoscaling')
    ec2 = boto3.client('ec2')

    for asg_name in asg_names:
        # Suspend Health Checks for the Auto Scaling Group
        try:
            autoscaling.suspend_processes(
                AutoScalingGroupName=asg_name,
                ScalingProcesses=['HealthCheck']
            )
            print(f"Health checks suspended for Auto Scaling Group: {asg_name}")
        except Exception as e:
            print(f"Error suspending health checks for Auto Scaling Group {asg_name}: {str(e)}")
            continue
        
        # Describe instances in the Auto Scaling Group
        try:
            response = autoscaling.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_name])
            instances = response['AutoScalingGroups'][0]['Instances']
        except Exception as e:
            print(f"Error describing instances for Auto Scaling Group {asg_name}: {str(e)}")
            continue

        # Stop the specified number of instances
        instances_to_stop = min(instances_to_stop, len(instances))
        instances_to_stop_ids = [instance['InstanceId'] for instance in instances[:instances_to_stop]]
        
        try:
            ec2.stop_instances(InstanceIds=instances_to_stop_ids)
            print(f"Stopped {instances_to_stop} instances in Auto Scaling Group: {asg_name}")
        except Exception as e:
            print(f"Error stopping instances in Auto Scaling Group {asg_name}: {str(e)}")

    return {
        'statusCode': 200,
        'body': 'Instances stopped and health checks suspended successfully'
    }
