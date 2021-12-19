from flask import Blueprint, request, jsonify, current_app
from werkzeug.utils import secure_filename
from bson.objectid import ObjectId
from functions import compreImagen, getSpecific
from uploadImage import UploadImage, DeleteImage
from listener import listener
from db import mongo
from os import remove, path

apiS = Blueprint("ProductSpecific", __name__)

@apiS.route('/editspecific', methods = ["POST"])
def editspecific():

    if( not request.form['id']):
        return {
            'status':404,
            'smg':'verifique sus datos'
        }

    if(request.form['title'] and 'image' in request.files):
        file = request.files['image']
        filename = secure_filename(file.filename)
        file.save(path.join(current_app.config['UPLOAD_FOLDER'], filename))
        
        # comprimiendo la imagen
        newfilename = compreImagen(filename)

        result = UploadImage(path=current_app.config['UPLOAD_FOLDER']+newfilename, name=newfilename)
        
        urlimage = result['link']
        resultp = mongo.db.client.pulperia.ProductSpecific.find_one({
            '_id': ObjectId(oid= request.form['id'])
        })
        
        DeleteImage(name=resultp['cloudimagename'])
        remove(current_app.config['UPLOAD_FOLDER'] + filename)
        remove(current_app.config['UPLOAD_FOLDER'] + newfilename)
        
        mongo.db.client.pulperia.ProductSpecific.update_one(filter = {
            '_id': ObjectId(oid= request.form['id']), 
        }, update = {
            '$set':{
                'Title': request.form['title'],
                'urlImage': urlimage,
                'cloudimagename': result['cloudfilename']
            }
        })
    elif(request.form['title']):
        mongo.db.client.pulperia.ProductSpecific.update_one(filter = {
            '_id': ObjectId(oid= request.form['id']), 
        }, update = {
            '$set':{
                'Title': request.form['title'],
            }
        })
    else:
        return {
            'status': 404,
            'smg':'verifique sus datos'
        }
    listener("productSpecific")
    return {
        'status': 200,
    }

@apiS.route('/addspecific', methods = ["POST"])
def addspecific():
    try:
        if(request.form['title'] and request.files['image'] and request.form['idgeneral']):
            file = request.files['image']
            filename = secure_filename(file.filename)
            file.save(path.join(current_app.config['UPLOAD_FOLDER'], filename))
        
            # comprimiendo la imagen
            newfilename = compreImagen(filename)
            
            result = UploadImage(path=current_app.config['UPLOAD_FOLDER']+newfilename, name=newfilename)
            urlimage = result['link']

            mongo.db.client.pulperia.ProductSpecific.insert_one({
                'Title': request.form['title'],
                '_idGeneral': ObjectId(oid=request.form['idgeneral']),
                'urlImage': urlimage,
                'cloudimagename': result['cloudfilename']
            })
            remove(current_app.config['UPLOAD_FOLDER'] + filename)
            remove(current_app.config['UPLOAD_FOLDER'] + newfilename)
            listener("productSpecific")
            return {
                'status': 200
            }
        else:
            return {
                'smg':'verifique sus datos',
                'status': 404
            }
    except Exception as e:
        print(e)
        return {
            'status': 404,
            'smg':'intente nuevamente'
        }

@apiS.route('/delspecific', methods=  ["POST"])
def delspecific():
    try:
        result = mongo.db.client.pulperia.ProductSpecific.find_one({
                '_id': ObjectId(oid=request.json['id'])
        })
        
        mongo.db.client.pulperia.ProductSpecific.delete_one(filter = {
            '_id': ObjectId(oid=request.json['id'])
        })

        DeleteImage(name=result['cloudimagename'])

        listener("productSpecific")
        return { 
            "status": 200,
        }
    except:
        return { 
            "status": 404,
        }

@apiS.route('/getspecific', methods=  ["POST", "GET"])
def routegetspecific():
    if request.method == "GET":
        return jsonify(getSpecific())
    elif request.method == "POST":
        return jsonify([{
            'id': str(product['_id']),
            'title': product['Title'],
            'urlimage': product['urlImage'],
            'idgeneral': str(product['_idGeneral'])
        }for product in mongo.db.client.pulperia.ProductSpecific.find({'_idGeneral': ObjectId(oid= request.json['id'])})])