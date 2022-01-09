import 'package:pulperia/models/ProductGenral.dart';
import 'package:pulperia/models/ProductSpecific.dart';

late List<ProductGeneral> listProductGeneral = [];
late Map<String, dynamic> dataRegisterProfile = {
  'user': '',
  'email': '',
  'password': '',
  'title': '',
  'coordenadas': {'latitude': 0.0, 'longitude': 0.0},
};
late Map<String, List<ProductSpecific>> listProductSpecific = {};
late String currenIndexData = "";
