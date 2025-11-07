import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;

class OpenStreetMap extends StatefulWidget {
  const OpenStreetMap({super.key});

  @override
  State<OpenStreetMap> createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  final loc.Location _location = loc.Location();
  String _address = "Đang lấy địa chỉ...";
  Future<void> _requestEnableGPS() async {
    bool serviceEnable;
    serviceEnable = await _location.serviceEnabled();
    if (!serviceEnable) {
      serviceEnable = await _location.requestService();
    }
    if (!serviceEnable) return;
  }

  Future<void> _requestEnablePermission() async {
    loc.PermissionStatus permissionGranted;
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      //denied -> chưa được cấp quyền
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted)
        return; //không được cấp quyền
    }
  }

  Future<void> _getUserLocation() async {
    final userLocation = await _location.getLocation();
    setState(() {
      _currentLocation = LatLng(
        userLocation.latitude!,
        userLocation.longitude!,
      );
      debugPrint(_currentLocation.toString());
    });
    List<Placemark> placemarks = await placemarkFromCoordinates(
      userLocation.latitude!,
      userLocation.longitude!,
    );
    Placemark place = placemarks.first;
    setState(() {
      _address =
          "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}. ";
      debugPrint(_address);
    });
  }

  Future<void> _getCurrentLocation() async {
    _requestEnableGPS();
    _requestEnablePermission();
    _getUserLocation();
    _mapController.move(_currentLocation!, 15);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? LatLng(0, 0),
              initialZoom: 2,
              minZoom: 0,
              maxZoom: 200,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.timetrack',
              ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  markerSize: Size(35, 35),
                  markerDirection: MarkerDirection.heading,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getCurrentLocation();
        },
        elevation: 0,
        backgroundColor: Colors.blue,
        child: Icon(Icons.my_location, size: 30, color: Colors.white),
      ),
    );
  }
}
