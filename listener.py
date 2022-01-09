import json
from datetime import datetime
from decimal import Decimal
from db import mongo
from bson.objectid import ObjectId

def listener(product: str):
    jsondata = jsonRead()
    fecha = getDay()
    if(product == "productGeneral"):
        if (jsondata['fecha'] != fecha):
            jsondata['fecha'] = fecha
            jsondata[product]['state']['version'] += 1
            jsondata[product]['state']['subversion'] = 0
        else:
            jsondata[product]['state']['subversion'] += 1
    elif(product == "productSpecific"):
        if (jsondata['fecha'] != fecha):
            jsondata['fecha'] = fecha
            jsondata[product]['state']['version'] += 1
            jsondata[product]['state']['subversion'] = 0
        else:
            jsondata[product]['state']['subversion'] += 1
    jsonWrite(jsondata)


# get fecha
def getDay():
    return datetime.now().strftime("%d-%m-%Y")


# get code
def getCode(product: str):
    jsondata = jsonRead()
    return Decimal("{0}.{1}".format(jsondata[product]['state']['version'],
                                    jsondata[product]['state']['subversion']))


# read data
def jsonRead():
    result = mongo.db.client.pulperia.state.find_one(ObjectId(oid="61da52dad9df26c85e98b02e"))


    return {
        'fecha': result['fecha'],
        'productGeneral': result['productGeneral'],
        'productSpecific': result['productSpecific'],
    }


# write data
def jsonWrite(dataJson):
    mongo.db.client.pulperia.state.update_one(filter = {
        '_id':ObjectId(oid="61da52dad9df26c85e98b02e")
    }, update = {
        "$set": dataJson}
    )
    with open('file.json', 'w') as file:
        json.dump(dataJson, file)
        file.close()
