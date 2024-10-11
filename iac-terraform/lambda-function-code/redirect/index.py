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
short_length_url = os.getenv('SHORT_URL_LENGTH')

def generate_short_id():
    return ''.join(random.choices(string.ascii_letters + string.digits, k=short_length_url))

def lambda_handler(event, context):
    logger.info("Inside the Handler function",event)
    code = event['pathParameters']['code']
    logger.info(code)

    if not code:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Code is required'})
        }

    try:
        logger.info("Inside the try block")
        response = dynamodb.get_item(
            Key = {
                'UrlCode': {
                    'S' : code
                }
            },
            TableName=table,
            ProjectionExpression='#u',
            ExpressionAttributeNames = {'#u': 'Url'}
        )
        logger.info(response)

        if not response['Item']:
            return {
                'statusCode': 404,
                'body': json.dumps({'error': 'Url not found'})
            }
    
        return {
            'statusCode': 200,
            'body': json.dumps({'url': response['Item']['Url']['S']})
        }
    
    except Exception as error:
         return {
            'statusCode': 500,
            'body': json.dumps({'message': str(error)})
         }
    
   