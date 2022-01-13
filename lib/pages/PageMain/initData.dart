import 'dart:math';

import 'package:pulperia/DataBase.dart';
import 'package:pulperia/data.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/models/ProductGenral.dart';
import 'package:http/http.dart' as http;
import 'package:pulperia/models/ProductSpecific.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'dart:convert';

Future<bool> initData() async {
  await BaseData().initDB();
  await PreferenceShared().initPref();

  //initial variables cache
  if (!PreferenceShared.pref!.containsKey('indexmapstyle'))
    PreferenceShared.pref!.setInt('indexmapstyle', 0);

  try {
    if (PreferenceShared.pref!.containsKey('firstInit')) {
      final response = await dio.post(
        ('/api/statusSync'),
        data: {
          "codeGeneral": PreferenceShared.pref!.getString('codeGeneral'),
          "codeSpecific": PreferenceShared.pref!.getString('codeSpecific'),
        },
      );

      if (response.statusCode == 200) {
        if (!response.data['syncGeneral']) {
          try {
            final res = await dio.post("/api/syncData", data: {
              "product": "productGeneral",
              "productGeneral": await BaseData.db!.query('ProductGeneral'),
            });

            if (res.statusCode == 200) {
              // agregando
              for (final element in res.data["data"]['add']) {
                await BaseData.db!.insert("ProductGeneral", element);
              }

              //eliminando
              for (final element in res.data["data"]['delete']) {
                BaseData.db!.delete("ProductGeneral",
                    where: "id = ?", whereArgs: [element['id']]);
              }

              //actualizando
              for (Map<String, dynamic> element in res.data["data"]
                  ['upgrade']) {
                await BaseData.db!.update("ProductGeneral", element,
                    where: 'id = ?', whereArgs: [element['id']]);
              }
              PreferenceShared.pref!
                  .setString('codeGeneral', res.data['codeGeneral']);
            }
          } catch (e) {
            print(e);
          }
        }

        if (!response.data['syncSpecific']) {
          try {
            var queryResult = [];
            for (var element in await BaseData().getAllSpecific()) {
              queryResult.add({
                'id': element.idm,
                'title': element.title,
                'urlimage': element.urlimage,
                'idgeneral': element.idgeneral,
              });
            }

            final res = await dio.post("/api/syncData", data: {
              "product": "productSpecific",
              "productSpecific": queryResult,
            });

            if (res.statusCode == 200) {
              // agregando
              for (var element in res.data["data"]['add']) {
                element.addAll({
                  'imagen': await networkImageToBase64(element['urlimage']),
                });
                await BaseData().inserProduct(ProductSpecific.fromMap(element));
              }

              //eliminando
              for (final element in res.data["data"]['delete']) {
                BaseData.db!.delete("ProductSpecific",
                    where: "id = ?", whereArgs: [element['id']]);
              }

              //actualizando
              for (Map<String, dynamic> element in res.data["data"]
                  ["upgrade"]) {
                final dataupgrade = await BaseData.db!.query('ProductSpecific',
                    where: "id = ?", whereArgs: [element['id']]);

                if (element['urlimage'] != dataupgrade[0]['urlimage']) {
                  element.addAll({
                    'imagen': await networkImageToBase64(element['urlimage']),
                  });
                } else {
                  element.remove('imagen');
                }
                await BaseData.db!.update("ProductSpecific", element,
                    where: 'id = ?', whereArgs: [element['id']]);
              }
              PreferenceShared.pref!
                  .setString('codeSpecific', res.data['codeSpecific']);
            }
          } catch (e) {}
        }
      }
    } else {
// primer incio
      try {
        final response = await dio.get('/api/syncData');
        if (response.statusCode == 200) {
          for (Map<String, dynamic> element
              in response.data['ProductGeneral']) {
            BaseData().inserProduct(ProductGeneral.fromMap(element));
          }

          for (var element in response.data['ProductSpecific']) {
            element.addAll({
              'imagen': await networkImageToBase64(element['urlimage']),
            });
            BaseData().inserProduct(ProductSpecific.fromMap(element));
          }
          PreferenceShared().setBkey('firstInit', true);

          PreferenceShared.pref!
              .setString('codeGeneral', response.data['codeGeneral']);
          PreferenceShared.pref!
              .setString('codeSpecific', response.data['codeSpecific']);
        }
      } catch (e) {
        return false;
      }
    }
  } catch (e) {}

  //obteniendo dela base de datos
  List<ProductGeneral> _datGeneral = await BaseData().getAllGeneral();
  _datGeneral = randGeneral(_datGeneral);
  final _datSpecific = Map<String, List<ProductSpecific>>();

  for (var element in _datGeneral) {
    _datSpecific.addAll({
      element.idm: await BaseData().getSpecific(element.idm),
    });
  }

  listProductGeneral = _datGeneral;
  listProductSpecific = _datSpecific;
  currenIndexData = _datGeneral[0].idm;

  return true;
}

Future<String> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  return base64Encode(bytes);
}

List<ProductGeneral> randGeneral(List<ProductGeneral> items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
