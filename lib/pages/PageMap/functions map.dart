import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void setMapFitToTour(Set<Polyline> p, GoogleMapController _mapController) {
  double minLat = p.first.points.first.latitude;
  double minLong = p.first.points.first.longitude;
  double maxLat = p.first.points.first.latitude;
  double maxLong = p.first.points.first.longitude;
  p.forEach((poly) {
    poly.points.forEach((point) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLong) minLong = point.longitude;
      if (point.longitude > maxLong) maxLong = point.longitude;
    });
  });
  _mapController.moveCamera(
    CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        120),
  );
}

initPermisos(Location _location, Future<void> callback) async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  // await _getPulperia();
  // await _showpulperias();
  await callback;

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

void currentLocation(GoogleMapController controller, Location _location) {
  _location.onLocationChanged.listen(
    (LocationData currentLocation) {
      // Use current location
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          ),
          17.5,
        ),
      );
    },
  );
}
