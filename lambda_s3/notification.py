import json
import boto3
import logging
import datetime
import os

# Configure the logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Create a lambda function to retrieve an environment variable
get_env_variable = lambda var_name: os.environ.get(var_name)

# Initialize SES client
ses = boto3.client('ses', region_name='eu-west-2')

sender_email = get_env_variable("SENDER_EMAIL")


def lambda_handler(event, context):

    # Check if 'Records' key exists in the event
    if 'Records' in event:
        records = event['Records']

        for record in records:
            # Check if the record contains the JSON object
            if 'body' in record:
                # Parse the JSON object from the record's body
                json_body = json.loads(record['body'])

                src_bucket = json_body.get('sourceBucket', '')
                logger.info("src_bucket:" + src_bucket)

                bizEmailAddress = json_body.get('businessEmailAddress', '')
                biz_email_value_list = [value.strip() for value in bizEmailAddress.split(",")]
                logger.info("biz_email_value_list: " + str(biz_email_value_list))
               
                supportEmailAddress = json_body.get('supportEmailAddress', '')
                support_email_value_list = [value.strip() for value in supportEmailAddress.split(",")]
                logger.info("support_email_value_list: " + str(support_email_value_list))
               
                bizNotification = json_body.get('bizNotification', '')
                supportNotification = json_body.get('supportNotification', '')
               
               
                flag = json_body.get('valid', '')
               
                if bizNotification == 'Y':
                    biz_email_notification(flag, json_body, biz_email_value_list)
                   
                if flag == 'false':
                    support_email_notification(flag, json_body, support_email_value_list)
                   

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


def biz_email_notification(flag, json_body, email_value_list):
    subject = construct_subject(flag, json_body)
       
    if flag == 'true':
        message = ''
    else:
        file_name = json_body.get('sourceFileKey', '')
        message = f"Submitted file {file_name} was not recognized, please conform to the agreed filename convention and resubmit if required."
       
    # Send the email to all recipients in email_value_list
    response = ses.send_email(
        Source=sender_email,
        Destination={'ToAddresses': email_value_list},
        Message={
            'Subject': {'Data': subject},
            'Body': {'Text': {'Data': message}}
        }
    )
    logger.info("response: " + str(response))


def support_email_notification(flag, json_body, email_value_list):
    subject = construct_subject(flag, json_body)

    file_name = json_body.get('sourceFileKey', '')
    message = construct_message_body(json_body)
       
    # Send the email to all recipients in email_value_list
    response = ses.send_email(
        Source=sender_email,
        Destination={'ToAddresses': email_value_list},
        Message={
            'Subject': {'Data': subject},
            'Body': {'Text': {'Data': message}}
        }
    )
    logger.info("response: " + str(response))




def construct_subject(flag, json_body):
    # DynamoDB table name
    swimlane = get_env_variable("SWIMLANE")
   
    file_name = json_body.get('sourceFileKey', '')


    if flag == 'true':
        if swimlane == 'PROD':
            subject = f"TIL Success: File:{file_name} -- Successfully Received"
        else:
            subject = f"{swimlane}: TIL Success: File:{file_name} -- Successfully Received"
    else:
        if swimlane == 'PROD':
            subject = f"TIL Failure: File:{file_name} -- Failed Processing (open email for details)"
        else:
            subject = f"{swimlane}: TIL Failure: File:{file_name} -- Failed Processing (open email for details)"
         
    return subject


def construct_message_body(json_body):
    src_bucket = json_body.get('sourceBucket', '')
    file_name = json_body.get('sourceFileKey', '')
    target_bucket_name = json_body.get('targetBucket', '')

    # Get the current date and time
    current_datetime = datetime.datetime.now().strftime("%d-%m-%Y %H:%M:%S")


    # Create the email message body with dynamic values
    message_body = f"Submitted file {file_name} was not recognised, business owner has been notified\n\n"
    message_body = f"Source System: {src_bucket}\n"
    message_body += f"File Name: {file_name}\n\n"
    message_body += f"Target Bucket: {target_bucket_name}\n\n"
    message_body += f"Date & Time: {current_datetime}\n\n"


    return message_body