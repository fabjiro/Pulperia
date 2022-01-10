from flask import Blueprint, request, jsonify, session
from validate_email_address import validate_email
from optGeneratos import SendOTP
from werkzeug.security import generate_password_hash, check_password_hash
from bson.objectid import ObjectId
from db import mongo

pulp = Blueprint("pulperia", __name__)

@pulp.route('/getpulperia', methods = ["POST", "GET"])
def getpulperia():
    if(request.method == "GET"):
        return jsonify([{
            'id': str(pulp['_id']),
            'title': pulp['Title'],
            'coordenadas': pulp['coordenadas'],
        } for pulp in mongo.db.client.pulperia.Pulperias.find()]), 200

@pulp.route('/registerpulperia', methods = ["POST"])
def registerpulperia():
    if('user' and 'email' and 'password' in request.json):
        if(request.json['user'] and request.json['email'] and request.json['password']):
            if(validate_email(request.json['email'], verify= True) != None):
                #unique email
                user = mongo.db.client.pulperia.User.find_one({
                    'email':request.json['email']
                })

                if user == None:
                    session['otpcode'] = SendOTP(request.json['email'])
                    return {
                        'status': 200
                    }
                else:
                    return {
                        'status': 404,
                        'smg':'usuario ya existe'
                    }
            else:
                return {
                    'status': 404,
                    'smg': 'verifique email'
                }
        else:
            return {
                'status':  404,
                'smg':'verifique los campos'
            }

    elif('otpcode' in request.json):
        if session['otpcode'] == request.json['otpcode']:
            return {
                'status': 200
            }
        else:
            return {
                'status': 404,
                'smg': 'verifique codigo'
            }

    elif('product' and 'data' in request.json):
        try:
            pulpdata = mongo.db.client.pulperia.Pulperias.insert_one({
                'Title': request.json['data']['title'],
                'coordenadas':{
                        'latitude': request.json['data']['coordenadas']['latitude'],
                        'longitude': request.json['data']['coordenadas']['longitude']
                },
                'product': [{
                    'idgeneral': ObjectId(oid=element['idgeneral']),
                    'idspecific': element['idspecific'],
                    
                } for element in request.json['product']],
            })

            userdata = mongo.db.client.pulperia.User.insert_one({
                'user': request.json['data']['user'],
                'email': request.json['data']['email'],
                'password': generate_password_hash(request.json['data']['password']),
                'pulperia': pulpdata.inserted_id
            })
            
            return {
                'status': 200,
                'iduser': str(userdata.inserted_id),
                'idpulperia': str(pulpdata.inserted_id),
                'user': request.json['data']['user']
            }
        except Exception as e:
            return {
                'status': 404,
            }
        return {
            'status': 404,
        }
    return {
        'status': 404,
        'smg':'verifique sus datos'
    }