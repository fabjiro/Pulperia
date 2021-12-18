from flask import Blueprint, request, jsonify, session
from bson.objectid import ObjectId
from functions import getGeneral
from listener import listener

from db import mongo

apiG = Blueprint("api",__name__)

@apiG.route('/addgeneral', methods = ["POST"])
def add():
    try:
        if(request.json['title']):
            mongo.db.client.pulperia.ProductGeneral.insert_one({'Title': request.json['title']})
            listener("productGeneral")
            return {
                'status': 200,
            }
        else:
            return {
                'status': 404,
                'smg': 'verifique sus campos'
            }
    except:
        return {
            'status': 404,
        }

@apiG.route('/getgeneral', methods = ["GET", "POST"])
def routergetGeneral():
    if request.method == "POST": #get unique product
        produt = getGeneral(id = request.json['id'])
        if produt:
            return produt
        else:
            return {
                'status': 404,
                'smg':'verifique sus datos'
            }
    else: #get all product
        return jsonify(getGeneral(id= None))

@apiG.route('/deletegeneral', methods = ["POST"])
def delete():
    try:
        mongo.db.client.pulperia.ProductGeneral.delete_one(filter = {
            '_id': ObjectId(oid=request.json['id'])
        })
        listener("productGeneral")
        return {
            "status": 200,
        }
    except:
        return {
            "status": 404,
        }
    return 'hola mundo'

@apiG.route('/updategeneral', methods = ["POST"])
def update():
    try:
        mongo.db.client.pulperia.ProductGeneral.update_one(filter = {
            "_id": ObjectId(oid=request.json['id'])
        },update= {"$set": {
            'Title': request.json['title']
        }})
        listener("productGeneral")
        return {
            'status': 200,
        }
    except Exception as e:
        return {
            'status':404,
            'smg':'verifique sus datos'
        }