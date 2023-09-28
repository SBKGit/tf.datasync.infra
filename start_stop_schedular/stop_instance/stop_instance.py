import boto3
import os

def lambda_handler(event, context):
    # Specify your Auto Scaling Group names
    #asg_names = ["test_2-asg", "test_1-asg"]
    autoscaling_names = os.environ['asg_name']
    asg_names = autoscaling_names.split(',')
    
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

        # Get all instance IDs in the Auto Scaling Group
        instance_ids = [instance['InstanceId'] for instance in instances]
        
        try:
            ec2.stop_instances(InstanceIds=instance_ids)
            print(f"Stopped {len(instance_ids)} instances in Auto Scaling Group: {asg_name}")
        except Exception as e:
            print(f"Error stopping instances in Auto Scaling Group {asg_name}: {str(e)}")

    return {
        'statusCode': 200,
        'body': 'All instances stopped and health checks suspended successfully'
    }
