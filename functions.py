from tempfile import NamedTemporaryFile
from bson.objectid import ObjectId
from flask import current_app
from PIL import Image
from db import mongo

def compreImagen(filename):
    image = Image.open(current_app.config['UPLOAD_FOLDER'] + filename)
    tf = NamedTemporaryFile()
    newfileName = tf.name.split(
        '/')[-1].replace('tmp', '') + "." + filename.split('.')[-1]
    image.save(current_app.config['UPLOAD_FOLDER'] +
               newfileName, optimize=True, quality=70)
    return newfileName

def getSpecific():
    return [{
            'id': str(product['_id']),
            'title': product['Title'],
            'urlimage': product['urlImage'],
            'idgeneral': str(product['_idGeneral'])
        } for product in mongo.db.client.pulperia.ProductSpecific.find()]
    

def getGeneral(id:str):
    if id == None:
        return [{
                'id': str(product['_id']),
                'title': product['Title']
        }for product in mongo.db.client.pulperia.ProductGeneral.find()]
    else:
        product = mongo.db.client.product.ProductGeneral.find_one({
            "_id": ObjectId(id)
        })

        return {
            'id': str(product['_id']),
            'title': product['Title'],
        }