import 'package:flutter/widgets.dart';

class ReacData extends ChangeNotifier {
  String? user;
  String? token;
  String? idpulperia;

  String? get gettoken => token;
  String? get getuser => user;
  String? get getidpulperia => idpulperia;

  set setuser(String value) {
    this.user = value;
    notifyListeners();
  }

  set settoken(String value) {
    this.token = value;
    notifyListeners();
  }

  set setidpulperia(String value) {
    this.idpulperia = value;
    notifyListeners();
  }

  ReacData({
    this.token,
    this.user,
    this.idpulperia,
  });
}
