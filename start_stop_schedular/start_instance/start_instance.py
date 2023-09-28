import boto3
import time
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
        # Unsuspend Health Checks for the Auto Scaling Group
        try:
            autoscaling.resume_processes(
                AutoScalingGroupName=asg_name,
                ScalingProcesses=['HealthCheck']
            )
            print(f"Health checks resumed for Auto Scaling Group: {asg_name}")
        except Exception as e:
            print(f"Error resuming health checks for Auto Scaling Group {asg_name}: {str(e)}")
            continue
        
        # Sleep for 5 seconds to allow health checks to resume
        time.sleep(5)

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
            ec2.start_instances(InstanceIds=instance_ids)
            print(f"Started {len(instance_ids)} instances in Auto Scaling Group: {asg_name}")
        except Exception as e:
            print(f"Error starting instances in Auto Scaling Group {asg_name}: {str(e)}")

    return {
        'statusCode': 200,
        'body': 'Health checks resumed and all instances started successfully'
    }
