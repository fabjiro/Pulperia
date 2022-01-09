import 'package:flutter/material.dart';
import 'package:pulperia/pages/OPTS/PageOptPulperia.dart';
import 'package:pulperia/pages/RegisterPulperia/PagaRegisterMain.dart';
import 'package:pulperia/pages/RegisterPulperia/PageSelecProducr.dart';
import 'package:pulperia/pages/RegisterPulperia/PageUbication.dart';

class PageRegisterPulperia extends StatefulWidget {
  PageRegisterPulperia({Key? key}) : super(key: key);

  @override
  _PageRegisterPulperiaState createState() => _PageRegisterPulperiaState();
}

class _PageRegisterPulperiaState extends State<PageRegisterPulperia> {
  final _pageController = PageController();
  int _currentIndex = 0;

  void navPage(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  void closePage() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            PageRegisterMain(pageController: _pageController, indexjump: 1),
            PageOPTRegister(pageController: _pageController, indexjump: 2),
            PageUbication(pageController: _pageController, indexMove: 3),
            PageSelecProduct(closePage: closePage),
          ],
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
