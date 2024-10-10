import json
import string
import random
import boto3

# Initialize the DynamoDB resource
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('url-shortener')

# Length of the short URL ID
SHORT_URL_LENGTH = 6

def generate_short_id():
    return ''.join(random.choices(string.ascii_letters + string.digits, k=SHORT_URL_LENGTH))

def lambda_handler(event, context):
    if event['httpMethod'] == 'POST':
        # Extract long URL from request
        body = json.loads(event['body'])
        long_url = body.get('long_url', None)
        
        if not long_url:
            return {
                'statusCode': 400,
                'body': json.dumps({'error': 'long_url is required'})
            }
        
        short_id = generate_short_id()
        table.put_item(Item={'short_id': short_id, 'long_url': long_url})
        
        return {
            'statusCode': 200,
            'body': json.dumps({'short_url': f"https://{event['headers']['Host']}/{short_id}"})
        }
    else:
        return {'statusCode': 405, 'body': json.dumps({'error': 'Method Not Allowed'})}
