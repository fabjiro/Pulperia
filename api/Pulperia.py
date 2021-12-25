from flask import Blueprint, request, jsonify
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