import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pulperia/data.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/models/ProductGenral.dart';
import 'package:pulperia/models/ProductSpecific.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

// selected products
Map<String, List<ProductSpecific>> selectedProducts = {};

class PageSelecProduct extends StatefulWidget {
  PageSelecProduct({Key? key, required this.closePage}) : super(key: key);

  final Function() closePage;
  @override
  _PageSelecProductState createState() => _PageSelecProductState();
}

class _PageSelecProductState extends State<PageSelecProduct> {
  bool isScrolluser = true;
  late ReacData _readReacData;

  @override
  void initState() {
    super.initState();
    _readReacData = context.read<ReacData>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() => isScrolluser = true);
              } else if (notification.direction == ScrollDirection.reverse) {
                setState(() => isScrolluser = false);
              }

              return true;
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 20),
              itemCount: listProductGeneral.length,
              itemBuilder: (BuildContext context, int index) {
                return ContainerProductSelector(
                  productGeneral: listProductGeneral[index],
                  listProductSpecific:
                      listProductSpecific[listProductGeneral[index].idm]!,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isScrolluser,
        child: FadeIn(
          child: FloatingActionButton(
            onPressed: () async {
              List<Map<String, dynamic>> data = [];
              print(dataRegisterProfile);
              if (selectedProducts.length > 2) {
                selectedProducts.forEach((key, value) {
                  List<String> temdata = [];
                  value.forEach((element) {
                    temdata.add(element.idm);
                  });
                  data.add({
                    'idgeneral': key,
                    'idspecific': temdata,
                  });
                });

                final result = await dio.post('/api/registerpulperia', data: {
                  'product': data,
                  'data': {
                    'user': dataRegisterProfile['user'],
                    'email': dataRegisterProfile['email'],
                    'password': dataRegisterProfile['password'],
                    'title': dataRegisterProfile['title'],
                    'coordenadas': {
                      'latitude': dataRegisterProfile['coordenadas']
                          ['latitude'],
                      'longitude': dataRegisterProfile['coordenadas']
                          ['longitude'],
                    },
                  },
                });

                if (result.data['status'] == 200) {
                  PreferenceShared.pref!.setString('user', result.data['user']);
                  PreferenceShared.pref!
                      .setString('token', result.data['iduser']);
                  PreferenceShared.pref!
                      .setString('idpulperia', result.data['idpulperia']);

                  //insert reacdata
                  _readReacData.settoken = result.data['iduser'];
                  _readReacData.setuser = result.data['user'];

                  widget.closePage();
                }
              } else {
                print("seleccione mas productos");
              }
            },
            child: Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}

class ContainerProductSelector extends StatelessWidget {
  const ContainerProductSelector({
    Key? key,
    required this.productGeneral,
    required this.listProductSpecific,
  }) : super(key: key);

  final ProductGeneral productGeneral;
  final List<ProductSpecific> listProductSpecific;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Container(
            width: 100.w,
            color: Colors.grey.withOpacity(.2),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  productGeneral.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ThemeApp.colorTitle.withOpacity(.5),
                  ),
                ),
                Text(
                  listProductSpecific.length.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ThemeApp.colorTitle.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          // chips
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: listProductSpecific
                    .map(
                      (e) => FilterChipWidget(
                        title: e.title,
                        changeState: (state) {
                          if (state) {
                            // add product to list
                            if (selectedProducts
                                .containsKey(productGeneral.idm)) {
                              selectedProducts[productGeneral.idm]!.add(e);
                            } else {
                              selectedProducts.addAll({
                                productGeneral.idm: [e],
                              });
                            }
                          } else {
                            // remove product to list
                            if (selectedProducts
                                .containsKey(productGeneral.idm)) {
                              selectedProducts[productGeneral.idm]!.remove(e);
                              if (selectedProducts[productGeneral.idm]!
                                      .length ==
                                  0) {
                                selectedProducts.remove(productGeneral.idm);
                              }
                            }
                          }
                        },
                      ),
                    )
                    .toList()),
          ),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  FilterChipWidget({
    Key? key,
    required this.title,
    required this.changeState,
  }) : super(key: key);

  final String title;
  final Function(bool) changeState;
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.title,
        style: TextStyle(
          color: isSelected
              ? ThemeApp.colorPrimario
              : ThemeApp.colorTitle.withOpacity(.5),
          fontSize: 12.sp,
        ),
      ),
      backgroundColor: ThemeApp.colorCard,
      selectedColor: ThemeApp.colorCard,
      checkmarkColor: ThemeApp.colorPrimario,
      shape: isSelected
          ? RoundedRectangleBorder(
              side: BorderSide(color: ThemeApp.colorPrimario, width: 1),
              borderRadius: BorderRadius.circular(12),
            )
          : RoundedRectangleBorder(
              side: BorderSide(
                  color: ThemeApp.colorTitle.withOpacity(.2), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
      selected: isSelected,
      onSelected: (state) {
        widget.changeState(state);
        setState(() => isSelected = state);
      },
    );
  }
}
