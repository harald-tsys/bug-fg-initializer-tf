# -*- coding:utf-8 -*-
import json

def init(context):
    logger = context.getLogger()
    logger.info("init")


def handler (event, context):
    logger = context.getLogger()
    
    logger.info(event)
      
    return {
        "statusCode": 200,
        "isBase64Encoded": False,
        "body": json.dumps(event),
        "headers": {
            "Content-Type": "application/json"
        }
    }