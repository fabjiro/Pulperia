import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart';
import 'package:pulperia/data.dart';
import 'package:pulperia/pages/PageLogin/textfielCustom.dart';
import 'package:pulperia/pages/PageMap/utils.dart';
import 'package:sizer/sizer.dart';

class PageUbication extends StatefulWidget {
  const PageUbication({
    Key? key,
    required this.pageController,
    required this.indexMove,
  }) : super(key: key);

  final PageController pageController;
  final int indexMove;
  @override
  _PageUbicationState createState() => _PageUbicationState();
}

class _PageUbicationState extends State<PageUbication> {
  TextEditingController _textfieldcontroller = new TextEditingController();
  late GoogleMapController _mapController;
  late Location _location;
  late LocationData _mylocation;

  @override
  void initState() {
    super.initState();
    _location = new Location();
  }

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              child: Text(
                "Ubiquese cerca de la pulperia para agregarla",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 4,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(500),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 65.w,
                  height: 30.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      heightFactor: 0.3,
                      widthFactor: 2.5,
                      child: FutureBuilder(
                        future: initPermisos(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            return GoogleMap(
                              initialCameraPosition: initialCamera,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              zoomGesturesEnabled: false,
                              zoomControlsEnabled: false,
                              rotateGesturesEnabled: false,
                              scrollGesturesEnabled: false,
                              onMapCreated: (controller) =>
                                  _mapcontroller(controller),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextfieldCustom(
              title: "Nombre de la tienda",
              icono: Iconsax.home,
              controller: _textfieldcontroller,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () {
                if (_textfieldcontroller.text.isNotEmpty) {
                  dataRegisterProfile['title'] = _textfieldcontroller.text;
                  dataRegisterProfile['coordenadas']['latitude'] =
                      _mylocation.latitude;
                  dataRegisterProfile['coordenadas']['longitude'] =
                      _mylocation.longitude;
                  widget.pageController.jumpToPage(widget.indexMove);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Iconsax.arrow_right_2,
                    color: Colors.red,
                    size: 35.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }

  initPermisos() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void _mapcontroller(GoogleMapController controller) async {
    _mapController = controller;
    _mylocation = await _location.getLocation();
    controller.setMapStyle(Utils.maplihg);
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          _mylocation.latitude!,
          _mylocation.longitude!,
        ),
        17,
      ),
    );
  }

  //mapa de nicaragua
  final initialCamera = CameraPosition(
    target: LatLng(12.865416, -85.207229),
    zoom: 7,
  );
}
