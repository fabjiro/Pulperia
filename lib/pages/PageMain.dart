import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pulperia/DataBase.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/pages/Components/dialogregister.dart';
import 'package:pulperia/pages/Modals/ModalRegister.dart';
import 'package:pulperia/pages/PageHome.dart';
import 'package:pulperia/pages/PageLoading.dart';
import 'package:pulperia/pages/PageMain/NavigationDrawer.dart';
import 'package:pulperia/pages/PageMain/initData.dart';
import 'package:pulperia/pages/PageMap.dart';
import 'package:pulperia/pages/PageNoInternet.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class PageMain extends StatefulWidget {
  PageMain({Key? key}) : super(key: key);

  @override
  PageMainState createState() => PageMainState();
}

class PageMainState extends State<PageMain> with AutomaticKeepAliveClientMixin {
  final _listScreen = [
    PageHome(),
    PageMap(),
  ];
  final _pageController = PageController();
  int _currentIndex = 0;
  late ReacData reacdata;
  late Future<bool> _noreload;

  @override
  void initState() {
    super.initState();
    _noreload = initData();
  }

  @override
  void dispose() {
    BaseData().closeBaseData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    reacdata = context.read<ReacData>();
    return FutureBuilder(
      future: _noreload,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: ScreenLoad(),
          );
        } else {
          if (snapshot.data!) {
            // initial reac data
            reacdata.settoken = PreferenceShared.pref!.containsKey('token')
                ? PreferenceShared.pref!.getString('token')!
                : 'null';
            reacdata.setuser = PreferenceShared.pref!.containsKey('user')
                ? PreferenceShared.pref!.getString('user')!
                : 'null';
            // ------------------
            return Scaffold(
              resizeToAvoidBottomInset: false,
              drawerEnableOpenDragGesture: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: PageView(
                controller: _pageController,
                children: _listScreen,
                physics: NeverScrollableScrollPhysics(),
              ),
              drawer: NavigationDrawer(),
              floatingActionButton: FadeInUp(
                duration: Duration(milliseconds: 600),
                child: FloatingActionButton(
                  onPressed: () {
                    if (PreferenceShared.pref!.getString('token') == null) {
                      modalRegister(
                        context,
                        DialogRegister(
                          ontap: () => Navigator.pushNamed(context, 'welcome'),
                        ),
                      );
                    }
                  },
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart,
                      size: 25.sp,
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: FadeInUp(
                duration: Duration(milliseconds: 600),
                child: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 10,
                  child: Container(
                    color: ThemeApp.colorBootomNavBar == Colors.white
                        ? null
                        : ThemeApp.colorBootomNavBar.withOpacity(.9),
                    height: 8.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => ontapNavbar(0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.home,
                                  color: _currentIndex == 0
                                      ? Theme.of(context).accentColor
                                      : Colors.grey[500],
                                  size: _currentIndex == 0 ? 25.sp : 20.sp,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: _currentIndex == 0
                                        ? Theme.of(context).accentColor
                                        : Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => ontapNavbar(1),
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.map_14,
                                  color: _currentIndex == 1
                                      ? Theme.of(context).accentColor
                                      : Colors.grey[500],
                                  size: _currentIndex == 1 ? 25.sp : 20.sp,
                                ),
                                Text(
                                  "Mapa",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: _currentIndex == 1
                                        ? Theme.of(context).accentColor
                                        : Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return PageNoInternet();
          }
        }
      },
    );
  }

  void ontapNavbar(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
