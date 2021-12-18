import base64
import requests
import json
from base64 import b64encode
from os import environ

def UploadImage(path:str, name:str):
    result = requests.request(
        'POST',
        url = environ.get("urlupimage"), 
        data = {
            'image': b64encode(open(path, 'rb').read()),
            'name': name
        }
    )   
    return json.loads(result.text)['data']['url']