import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/pages/PageLogin.dart';
import 'package:pulperia/pages/PageMain.dart';
import 'package:pulperia/pages/OPTS/PageOTP.dart';
import 'package:pulperia/pages/PageRegisterPulperia.dart' as PGR;
import 'package:pulperia/pages/PageRegisterUser.dart' as PGU;
import 'package:pulperia/pages/PageWelcome.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ),
  );

  dio = new Dio(
    BaseOptions(baseUrl: "https://fpulperia.herokuapp.com"),
  );
  dio.interceptors.add(CookieManager(CookieJar()));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ReacData>(create: (_) => ReacData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Pulperia',
          debugShowCheckedModeBanner: true,
          themeMode: ThemeMode.system,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          initialRoute: 'main',
          routes: {
            'main': (context) => PageMain(),
            'login': (context) => PageLogin(),
            'register': (context) => PGU.PageRegisterUser(),
            'registerpulperia': (context) => PGR.PageRegisterPulperia(),
            'welcome': (context) => PageWelcome(),
            'opt': (context) => PageOTP(),
          },
        );
      },
    );
  }
}
