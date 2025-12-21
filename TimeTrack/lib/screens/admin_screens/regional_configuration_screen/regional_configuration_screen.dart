// import 'package:flutter/material.dart';
// import 'package:timetrack/contains/app_colors.dart';
//
// class RegionalConfigurationScreen extends StatelessWidget {
//   const RegionalConfigurationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         title: Text(
//           "CẤU HÌNH KHU VỰC",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             fontFamily: 'balooPaaji',
//             color: AppColors.backgroundAppBar,
//           ),
//         ),
//         centerTitle: true,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:timetrack/screens/common_screens/document_screen/widgets/text_form_field_widget.dart';

import '../../../contains/app_colors.dart';

class RegionalConfigurationScreen extends StatefulWidget {
  const RegionalConfigurationScreen({
    super.key,
    required this.kvLat,
    required this.kvLon,
    required this.banKinh,
    required this.tenKv,
  });

  final String tenKv;
  final double kvLat;
  final double kvLon;
  final double banKinh;

  @override
  State<RegionalConfigurationScreen> createState() =>
      _RegionalConfigurationScreenState();
}

class _RegionalConfigurationScreenState
    extends State<RegionalConfigurationScreen> {
  final MapController _mapController = MapController();
  late TextEditingController _tenKvController = TextEditingController();
  late TextEditingController _latController = TextEditingController();
  late TextEditingController _lonController = TextEditingController();
  late TextEditingController _banKinhController = TextEditingController();

  late LatLng _tamDiem = LatLng(0, 0);
  late double _banKinh = 100;
  late String _diaChi = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tamDiem = LatLng(widget.kvLat, widget.kvLon);
    _banKinh = widget.banKinh;
    _tenKvController = TextEditingController(text: widget.tenKv.toString());
    _latController = TextEditingController(text: widget.kvLat.toString());
    _lonController = TextEditingController(text: widget.kvLon.toString());
    _banKinhController = TextEditingController(text: widget.banKinh.toString());
    _getLocation();
  }

  Future<void> _getLocation() async {
    final placeMark = await placemarkFromCoordinates(
      _tamDiem.latitude,
      _tamDiem.longitude,
    );
    final place = placeMark.first;
    _diaChi =
        "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}. ";
    debugPrint(_diaChi);
  }

  void _updateMap() {
    final lat = double.tryParse(_latController.toString());
    final lon = double.tryParse(_lonController.toString());
    final banKinh = double.tryParse(_banKinhController.toString());
    if (lat == null || lon == null || banKinh == null) return;
    final newTamDiem = LatLng(lat, lon);
    setState(() {
      _tamDiem = LatLng(lat, lon);
      _banKinh = banKinh;
    });
    _mapController.move(_tamDiem, 15);
    _getLocation();
  }

  void _updateForm(LatLng latLng) {
    setState(() {
      _tamDiem = latLng;
      _latController.text = latLng.latitude.toStringAsFixed(6);
      _lonController.text = latLng.longitude.toStringAsFixed(6);
    });
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "CẤU HÌNH KHU VỰC",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'balooPaaji',
            color: AppColors.backgroundAppBar,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormFieldWidget(
              hintText: 'Tên khu vực',
              onChanged: (value) {},
              maxLines: 1,
              initialValue: null,
              controller: _tenKvController,
            ),
            SizedBox(height: 10 * height / 956),
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    hintText: 'Vĩ độ (latitude)',
                    onChanged: (value) {},
                    maxLines: 1,
                    initialValue: null,
                    controller: _latController,
                  ),
                ),
                SizedBox(width: 10 * width / 440),
                Expanded(
                  child: TextFormFieldWidget(
                    hintText: 'Kinh độ (longitude)',
                    onChanged: (value) {},
                    maxLines: 1,
                    initialValue: null,
                    controller: _lonController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10 * height / 956),
            TextFormFieldWidget(
              hintText: 'Bán kính',
              onChanged: (value) {},
              maxLines: 1,
              initialValue: null,
              controller: _banKinhController,
            ),
            SizedBox(height: 20 * height / 956),
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _tamDiem,
                  initialZoom: 16,
                  onTap: (tapPosition, latLng) {
                    _updateForm(latLng);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "com.example.timetrack",
                  ),
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: _tamDiem,
                        radius: _banKinh,
                        useRadiusInMeter: true,
                        color: Colors.blue.withOpacity(0.25),
                        borderColor: Colors.blue,
                        borderStrokeWidth: 2,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _tamDiem,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
