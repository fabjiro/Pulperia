from flask import Blueprint, request, jsonify, session
from uuid import uuid4
from werkzeug.security import check_password_hash, generate_password_hash
from db import mongo

login = Blueprint("login", __name__)


@login.route('/accessadmin', methods = ["POST"])
def access():
    try:
        if request.json['username'] and request.json['password']:
            user = mongo.db.client.pulperia.UserAdmin.find_one({
                "username": request.json['username']
            })
            if user:
                if(check_password_hash(user['password'], request.json['password'])):
                    session['token'] = uuid4()
                    return jsonify(status = 200) 
                else:
                    return jsonify(smg = "verifique los datos", status = 404)
            else:
                return jsonify(smg = "verifique los datos", status = 404)
        else:
            return jsonify(smg = "rellene los campos", status = 404)
    except:
        return jsonify(smg = "intente nuevamente", status = 404)