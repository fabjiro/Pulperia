from flask import Flask, request
from db import mongo
from os import environ

from frontend import front
from api.login import login
from api.ProductGeneral import apiG
from api.ProductSpecific import apiS
from api.SincData import sinc
from api.User import user
from api.Pulperia import pulp

app = Flask(__name__)

# configuraciones
app.config['SECRET_KEY'] = environ.get("secretkey")
app.config['MONGO_URI'] = environ.get("mongouri")
app.config['UPLOAD_FOLDER'] = './img/'

#database init
mongo.init_app(app)

#register blueprint
app.register_blueprint(front)
app.register_blueprint(login, url_prefix= "/api")
app.register_blueprint(apiG, url_prefix= "/api")
app.register_blueprint(apiS, url_prefix= "/api")
app.register_blueprint(sinc, url_prefix ="/api")
app.register_blueprint(user, url_prefix = "/api")
app.register_blueprint(pulp, url_prefix= '/api')

if __name__ == "__main__":
    # app.run(host = "0.0.0.0",debug = True)
    app.run()