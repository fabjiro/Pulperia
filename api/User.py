from flask import Blueprint, request, jsonify, session
from werkzeug.security import generate_password_hash, check_password_hash
from validate_email_address import validate_email
from db import mongo
from optGeneratos import SendOTP

user = Blueprint("user", __name__)

@user.route('/chechcode', methods = ["POST"])
def chechcode():
    if(session['otpcode'] == request.json['otpcode']):
        mongo.db.client.pulperia.User.insert_one({
            'user': session['user'],
            'email': session['email'],
            'password': generate_password_hash(session['password']),
        })

        

        result = mongo.db.client.pulperia.User.find_one({
            'email': session['email']
        })

        #clear coockies
        session.pop('user')
        session.pop('email')
        session.pop('password')
        session.pop('otpcode')
        
        return {
            'status': 200,
            'token': str(result['_id']),
            'user': result['user']
        }
    return {
        'status': 404,
        'smg': 'verifique su codigo'
    }

@user.route('/login', methods = ["POST"])
def login():
    if(request.json['email'] and request.json['password']):
        if(validate_email(request.json['email'])):
            user = mongo.db.client.pulperia.User.find_one({
                'email':request.json['email']
            })

            if user:

                if(check_password_hash(user['password'], request.json['password'])):
                    return {
                        'status': 200,
                        'token': str(user['_id']),
                        'user': user['user'],
                    }
                else:
                    return {
                        'status': 404,
                        'smg': 'verifique la contrasena'
                    }
            else:
                return {
                    'status': 404,
                    'smg':'usuario no existe'
                }
        else:
            return {
                'status': 404,
                'smg': 'verifique email'
            }
    else:
        return {
            'status': 404,
            'smg':'verifique los campos'
        }

@user.route('/register', methods = ["POST"])
def regitser():
    #validate data
    if(request.json['user'] and request.json['email'] and request.json['password']):
        #validate email and exist
        if(validate_email(request.json['email'], verify= True) != None):
            #unique email
            user = mongo.db.client.pulperia.User.find_one({
                'email':request.json['email']
            })

            if(user == None):
                session['user'] = request.json['user']
                session['email'] = request.json['email']
                session['password'] = request.json['password']
                
                session['otpcode'] = SendOTP(request.json['email'])

                return {
                    'status': 200
                }
            else:
                return {
                    'status': 404,
                    'smg': 'email existe'
                }
        else:
            return {
                'status': 404,
                'smg': 'verifique email'
            }
    else:
        return {
            'status': 404,
            'smg': 'complete los campos'
        }