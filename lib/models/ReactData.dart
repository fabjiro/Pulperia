import 'package:flutter/widgets.dart';

class ReacData extends ChangeNotifier {
  String? user;
  String? token;

  String? get gettoken => token;
  String? get getuser => user;

  set setuser(String value) {
    this.user = value;
    notifyListeners();
  }

  set settoken(String value) {
    this.token = value;
    notifyListeners();
  }

  ReacData({
    this.token,
    this.user,
  });
}
