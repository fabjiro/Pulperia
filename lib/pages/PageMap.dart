import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/pages/PageMap/ModalChangeMap.dart';
import 'package:pulperia/pages/PageMap/ModalViewPulperia.dart';
import 'package:pulperia/pages/PageMap/SearchBtn.dart';
import 'package:pulperia/pages/PageMap/functions%20map.dart';
import 'package:provider/provider.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';

class PageMap extends StatefulWidget {
  PageMap({Key? key}) : super(key: key);

  @override
  _PageMapState createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> with AutomaticKeepAliveClientMixin {
  late Location _location;
  late LocationData _mylocation;
  late BitmapDescriptor mapIcon;
  late Future _noreload;
  Set<Marker> _markets = {};
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylinescoordinates = [];
  late PolylinePoints polylinePoints;

  late GoogleMapController _mapController;
  late ReacData watchreacdata;
  late ReacData readreacdata;
  late MapType _mapType;
  //call setstate
  void callSetstate(int indexmap) {
    setState(() {
      _mapType = intToMapstyle(indexmap);
    });
  }

  MapType intToMapstyle(int indexmap) {
    if (indexmap == 0) {
      return MapType.normal;
    } else if (indexmap == 1) {
      return MapType.hybrid;
    }
    return MapType.normal;
  }

  //mapa de nicaragua
  final initialCamera = CameraPosition(
    target: LatLng(12.865416, -85.207229),
    zoom: 7,
  );

  void setCustomIcon() async {
    mapIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      "assets/png/IconMap.png",
    );
  }

  @override
  void initState() {
    _location = new Location();
    _noreload = initPermisos(_location, _showpulperias());
    polylinePoints = PolylinePoints();
    setCustomIcon();
    readreacdata = context.read<ReacData>();
    _mapType = intToMapstyle(PreferenceShared.pref!.getInt('indexmapstyle')!);
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    watchreacdata = context.watch<ReacData>();
    super.build(context);
    return Stack(
      children: [
        Positioned.fill(
          child: FutureBuilder(
            future: _noreload,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                return GoogleMap(
                  mapType: _mapType,
                  markers: _markets,
                  polylines: _polylines,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: initialCamera,
                  onMapCreated: (controller) => mapCreate(controller),
                );
              }
            },
          ),
        ),
        // btn my location
        Positioned(
          top: 13.h,
          right: 8,
          child: InkWell(
            onTap: () => mylocation(),
            child: Card(
              elevation: 5,
              color: ThemeApp.colorTitleInvert,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Iconsax.location,
                  color: ThemeApp.colorPrimario,
                ),
              ),
            ),
          ),
        ),
        // btn chage map style
        Positioned(
          top: 20.h,
          right: 8,
          child: InkWell(
            onTap: () {
              // _mapController.setMapStyle(Utils.mapDark);
              modalChageMap(context, callSetstate);
            },
            child: Card(
              elevation: 5,
              color: ThemeApp.colorTitleInvert,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Iconsax.map_1,
                  color: ThemeApp.colorPrimario,
                ),
              ),
            ),
          ),
        ),
        //btn search
        SearchBtn(),
      ],
    );
  }

  void mapCreate(GoogleMapController controller) async {
    _mapController = controller;
    controller.setMapStyle(ThemeApp.mapStyle); //map style
    _mylocation = await _location.getLocation();
    // _showpulperias();
    mylocation();
  }

  void mylocation() {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          _mylocation.latitude!,
          _mylocation.longitude!,
        ),
        17,
      ),
    );
  }

  _showpulperias() async {
    final result = await dio.get("/api/getpulperia");
    for (Map<String, dynamic> element in result.data) {
      _markets.add(
        Marker(
          markerId: MarkerId(element['id']),
          position: LatLng(element['coordenadas']['latitude'],
              element['coordenadas']['longitude']),
          icon: mapIcon,
          onTap: () async {
            Map<String, String> data = await _showPolyline(
              PointLatLng(_mylocation.latitude!, _mylocation.longitude!),
              PointLatLng(element['coordenadas']['latitude'],
                  element['coordenadas']['longitude']),
            );

            modalViewPulperia(
              context,
              data,
              element,
            );
          },
          infoWindow: InfoWindow(
            title: element['title'],
          ),
        ),
      );
    }
  }

  Future<Map<String, String>> _showPolyline(
      PointLatLng origin, PointLatLng destination) async {
    polylinescoordinates.clear();

    final result = await dio.get(
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=AIzaSyCM4C69SRFNQz2rpDHAeUXN_wErf9urJos");

    if (result.data['status'] == "OK") {
      for (Map<String, dynamic> element in result.data["routes"][0]["legs"][0]
          ["steps"]) {
        polylinescoordinates.add(
          LatLng(
            element['start_location']['lat'],
            element['start_location']['lng'],
          ),
        );
        polylinescoordinates.add(
          LatLng(
            element['end_location']['lat'],
            element['end_location']['lng'],
          ),
        );
      }
    }

    setState(() {
      _polylines.add(
        Polyline(
          width: 13,
          color: Colors.blueAccent,
          points: polylinescoordinates,
          polylineId: PolylineId('line'),
        ),
      );
      setMapFitToTour(_polylines, _mapController);
    });

    return {
      'duration': result.data["routes"][0]["legs"][0]['duration']['text'],
      'distance': result.data["routes"][0]["legs"][0]['distance']['text'],
      "addres": result.data["routes"][0]["legs"][0]['end_address'],
    };
  }

  @override
  bool get wantKeepAlive => true;
}
