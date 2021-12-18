import json
from datetime import datetime
from decimal import Decimal

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
    jsondata = {}
    with open('file.json', 'r') as file:
        jsondata = (json.load(file))
        file.close()
    return jsondata


# write data
def jsonWrite(dataJson):
    with open('file.json', 'w') as file:
        json.dump(dataJson, file)
        file.close()
