import json
import boto3
import os
import logging

# Configure the logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

 # Create a lambda function to retrieve an environment variable
get_env_variable = lambda var_name: os.environ.get(var_name)

def lambda_handler(event, context):
    # Check if 'Records' key exists in the event
    if 'Records' in event:
        records = event['Records']

        for record in records:
            # Check if the record contains the JSON object
            if 'body' in record:
                # Parse the JSON object from the record's body
                json_body = json.loads(record['body'])

                final = json.loads(json_body)
                print(f"Final Payload: {final}")

                print(copy_to_target(final))

                send_to_sqs(final)

 

            else:
                logger.info("JSON object not found in the record's body")
    else:
        logger.info("Records' key not found in the event")

 
def copy_to_target(final):
    s3_client = boto3.client('s3')

    src_bucket = final.get('sourceBucket', '')
    src_file_key = final.get('sourceFileKey', '')
    target_bucket = final.get('targetBucket', '')

    success = True  # Initialize a success flag

    try:

       
        s3_client.copy_object(
            CopySource={'Bucket': src_bucket, 'Key': src_file_key},
            Bucket=target_bucket,
            Key=src_file_key
        )
    except Exception as e:
        print(f'Error copying file to {target_bucket}: {str(e)}')
        success = False  # Set the success flag to False if there's an error

    if success:
        return {
            'statusCode': 200,
            'body': 'File copied successfully to all target buckets'
        }
    else:
        return {
            'statusCode': 500,
            'body': 'Error copying file to one or more target buckets'
        }

 
def send_to_sqs(final):
 

    # Define the name of your SQS queue
    queue_name = get_env_variable("NOTIF_SQS_NAME")


    # Create an SQS client
    sqs_client = boto3.client('sqs')

    # Convert the 'final' dictionary to a JSON string
    message_body = json.dumps(final) 

    try:
        # Get the URL of the SQS queue by name
        queue_url = sqs_client.get_queue_url(QueueName=queue_name)['QueueUrl']

 

        # Send the message to the queue
        sqs_client.send_message(
            QueueUrl=queue_url,
            MessageBody=message_body
        )
 

        return 'Message sent to SQS queue successfully'


    except Exception as e:
        return f'Error sending message to SQS queue: {str(e)}'