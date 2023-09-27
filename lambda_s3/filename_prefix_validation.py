import json
import logging
import boto3
import os

# Configure the logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Create a lambda function to retrieve an environment variable
get_env_variable = lambda var_name: os.environ.get(var_name)


# Initialize the DynamoDB client
dynamodb = boto3.client('dynamodb')

# Initialize the SNS client
sns = boto3.client('sns')

def lambda_handler(event, context):
    # Convert the event to a JSON string
    event_json = json.dumps(event)

    # Parse the JSON string into a Python dictionary
    data = json.loads(event_json)
   
    process_message(data)

    return {
        'statusCode': 200,
        'body': json.dumps('Event processing complete')
    }

# Process the message
def process_message(data):
   
    # Extract bucket name
    src_bucket_name = data.get("detail", {}).get("bucket",{}).get("name")
    logger.info("Source Bucket name:"+src_bucket_name)
   
    # Extract key or filename
    src_file_key=data.get("detail", {}).get("object",{}).get("key")
    file_name = data.get("detail", {}).get("object",{}).get("key")
   
    # This logic is to get filename and prefix
    final_file_name=file_name.split("/")
    last_part_file_name = final_file_name[-1]
    logger.info("Last Part File name:"+last_part_file_name)
   
    prefix_str=get_prefix(last_part_file_name)
    logger.info("Prefix:"+prefix_str)
   
   
    if check_prefix_exists(prefix_str)=='Valid':
       
        # Send to SNS
        push_to_sns(get_values_based_on_prefix(prefix_str,src_bucket_name,src_file_key,'true'),'true')
       
    else:
        push_to_sns(get_values_based_on_src_bucket(src_bucket_name,src_file_key,'false'),'false')

    return {
        'statusCode': 200,
        'body': json.dumps('Event processing complete')
    }
   

# Get Prefix Based on the filename
def get_prefix(last_part_file_name):
   # Split the string by the first hyphen "-"
    parts = last_part_file_name.split('-', 1)
         # Check if there is at least one hyphen in the string
    if len(parts) > 1:
        prefix = parts[0]
    else:
        prefix = last_part_file_name  # If no hyphen found, consider the whole string as the prefix
   
    return prefix
   
# Check whether Prefix exists in DynamoDB    
def check_prefix_exists(prefix_str):

    # DynamoDB table name
    dyanmo_prefix_lookup_table_var_value = get_env_variable("DYNAMO_TABLE_PREFIX_LOOKUP")

    try:
        response = dynamodb.query(
            TableName=dyanmo_prefix_lookup_table_var_value,
            KeyConditionExpression='Prefix = :prefix',
            ExpressionAttributeValues={
                ':prefix': {'S': prefix_str}
            },
            Limit=1  # Limit the result to one item
        )

        # If an item is found, it exists in the table
        if len(response['Items']) > 0:
            return 'Valid'
        else:
            return 'Invalid'
           
    except Exception as e:
        print(f"Error: {str(e)}")
        return 'Invalid'
 
   
# Get Values based on Prefix from Dynamo  
def get_values_based_on_prefix(prefix_str,src_bucket_name,src_file_key,flag):
   
    # DynamoDB table name
    dyanmo_prefix_lookup_table_var_value = get_env_variable("DYNAMO_TABLE_PREFIX_LOOKUP")

    try:
        # Perform a DynamoDB query based on the key
        response = dynamodb.query(
            TableName=dyanmo_prefix_lookup_table_var_value,
            KeyConditionExpression='Prefix = :prefix',
            ExpressionAttributeValues={
                ':prefix': {'S': prefix_str}
            }
        )
       # Extract the results
        items = response.get('Items', [])

        # Process the retrieved items (e.g., extract attributes)
        for item in items:
            business_email = item.get('BusinessEmailAddress', {}).get('S')
            target_bucket_name = item.get('TargetBucket', {}).get('S')
            support_email= item.get('SupportEmailAddress', {}).get('S')
            business_notification= item.get('BizSuccessNotif', {}).get('S')
            support_notification= item.get('TechSupportSuccessNotif', {}).get('S')
           
            payload = {
              "businessEmailAddress":business_email,
              "supportEmailAddress":support_email,
              "sourceBucket":src_bucket_name,
              "sourceFileKey":src_file_key,
              "targetBucket":target_bucket_name,
              "bizNotification":business_notification,
              "supportNotification":support_notification,
              "valid":flag
            }
        return json.dumps(payload)

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

# Get Values based on source bucket name from Dynamo  
def get_values_based_on_src_bucket(src_bucket_name,src_file_key,flag):
   
    # DynamoDB table name
    dyanmo_error_notif_table_var_value = get_env_variable("DYNAMO_TABLE_ERROR_NOTIF")

    # DynamoDB table name
    table_name = dyanmo_error_notif_table_var_value  # Replace with your table name
   
    try:
        # Perform a DynamoDB query based on the key
        response = dynamodb.query(
            TableName=table_name,
            KeyConditionExpression='SourceBucket = :SourceBucket',
            ExpressionAttributeValues={
                ':SourceBucket': {'S': src_bucket_name}
            }
        )
       # Extract the results
        items = response.get('Items', [])
       
        for item in items:
            business_email = item.get('BusinessEmailAddress', {}).get('S')
            target_bucket_name = item.get('TargetBucket', {}).get('S')
            support_email= item.get('SupportEmailAddress', {}).get('S')
            business_notification= item.get('BizSuccessNotif', {}).get('S')

           
            payload = {
              "businessEmailAddress":business_email,
              "supportEmailAddress":support_email,
              "sourceBucket":src_bucket_name,
              "sourceFileKey":src_file_key,
              "targetBucket":target_bucket_name,
              "bizNotification":business_notification,
              "valid":flag
            }

        return json.dumps(payload)
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }


# Push message to SNS topic with message attribute      
def push_to_sns(json_string,flag):
   
    # SNS ARN value
    sns_arn_var_value = get_env_variable("SNS_TOPIC_ARN")

    # Replace 'YourTopicARN' with the ARN of your SNS topic
    topic_arn = sns_arn_var_value
   
    # Message attributes
    message_attributes = {
        'Valid': {
            'DataType': 'String',
            'StringValue': flag
        }
    }
   
    # Publish the message to the SNS topic
    sns.publish(
        TopicArn=topic_arn,
        Message=json.dumps({'default': json.dumps(json_string)}),
        MessageAttributes=message_attributes,
        MessageStructure='json'
    )
   
    return {
        'statusCode': 200,
        'body': json.dumps('Message published to SNS')
    }
