import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;

class OpenStreetMap extends StatefulWidget {
  const OpenStreetMap({
    super.key,
    required this.onChangeAddress,
    required this.kvLat,
    required this.kvLon,
    required this.banKinh,
  });

  final Function(String?, double, double) onChangeAddress;
  final double kvLat;
  final double kvLon;
  final double banKinh;

  @override
  State<OpenStreetMap> createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  final loc.Location _location = loc.Location();
  late String _address;

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
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }
  }

  Future<void> _getUserLocation() async {
    final userLocation = await _location.getLocation();
    final lat = userLocation.latitude;
    final lon = userLocation.longitude;
    setState(() {
      _currentLocation = LatLng(lat!, lon!);
      debugPrint(_currentLocation.toString());
    });
    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lon!);
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
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentLocation ?? LatLng(widget.kvLat, widget.kvLon),
          initialZoom: 16,
          minZoom: 3,
          maxZoom: 19,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.timetrack',
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: LatLng(widget.kvLat, widget.kvLon),
                radius: widget.banKinh,
                useRadiusInMeter: true,
                color: Colors.blue.withOpacity(0.25),
                borderColor: Colors.blue,
                borderStrokeWidth: 2,
              ),
            ],
          ),
          if (_currentLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
