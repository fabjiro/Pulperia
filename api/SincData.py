from flask import Blueprint, request, jsonify
from functions import getGeneral, getSpecific
from listener import getCode

sinc = Blueprint("sincdata", __name__)

@sinc.route('/statusSync', methods = ["POST"])
def statusSync():
    return jsonify(
        syncGeneral=str(getCode("productGeneral")) == request.get_json()['codeGeneral'],
        syncSpecific=str(getCode("productSpecific")) == request.get_json()['codeSpecific'])

@sinc.route('/syncData', methods=['GET', 'POST'])
def sincData():
    codeGeneral = getCode("productGeneral")
    codeSpecific = getCode("productSpecific")
    if (request.method == "GET"):
        return jsonify(
            ProductGeneral=getGeneral(id=None),
            ProductSpecific=getSpecific(),
            codeGeneral=codeGeneral,
            codeSpecific=codeSpecific,
        )
    elif(request.method == "POST"):
        jsonData = request.get_json()
        if(jsonData['product'] == "productGeneral"):
            return jsonify(data=sincData().getData(listserver=getGeneral(id = None), listlocal=jsonData['productGeneral']), codeGeneral=codeGeneral)
        elif(jsonData['product'] == "productSpecific"):
            return jsonify(
                data=sincData().getData(
                    listserver=getSpecific(),
                    listlocal=jsonData['productSpecific']
                ), codeSpecific=codeSpecific)  
# sincronizacion de la data

class sincData:
    def getData(self, listserver=[], listlocal=[]):

        salida = {
            "upgrade": {},
            "delete": {},
            "add": {},
        }
        diferente = self.getdiferent(listserver, listlocal)
        # haciendo cambios
        salida["upgrade"] = self.cambios(listlocal, diferente)

        # elimininandp
        salida["delete"] = self.getdiferent(listlocal, listserver)

        # agregando
        salida["add"] = self.getdiferent(listserver, listlocal)
        return salida

    def getdiferent(self, lista1=[], lista2=[]):
        salida = []
        for element in lista1:
            if(element not in lista2):
                salida.append(element)

        return salida

    def cambios(self, listlocal=[], diferente=[]):
        salida = []
        for index, element in enumerate(listlocal):
            for element2 in diferente:
                if(element['id'] == element2['id']):
                    salida.append(element2)
                    listlocal[index] = element2
                    break
        return salida
