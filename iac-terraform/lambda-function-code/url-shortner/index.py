import json
import string
import random
import boto3
import os

import logging
logger = logging.getLogger()
logger.setLevel("INFO")

# Initialize the DynamoDB resource
dynamodb = boto3.client('dynamodb')
table = os.getenv('TABLE_NAME')

# Length of the short URL ID
CODE_LENGTH = 6

def generate_short_id():
    logger.info("inside generate")
    return ''.join(random.choices(string.ascii_letters + string.digits, k=CODE_LENGTH))

def lambda_handler(event, context):
    logger.info(event['body'])
    logger.info("Inside the Handler function",event)
    body = json.loads(event['body'])
    url = body.get('url', None)

    if not url:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Url is required'})
        }

    try:
        logger.info("Inside the try")
        code = generate_short_id()
        logger.info(type(code))
        response = dynamodb.put_item(TableName = table, Item={'UrlCode': {'S': code}, 'Url': {'S':url}})
        logger.info(response)
        return {
            'statusCode': 200,
            'body': json.dumps({'short_url': f"https://{event['headers']['Host']}/{code}"})
        }
    except Exception as error:
         return {
            'statusCode': 500,
            'body': json.dumps({'message': str(error)})
         }
