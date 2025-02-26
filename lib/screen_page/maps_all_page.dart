
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../Model/kampus_Model.dart';

class MapsAllPage extends StatefulWidget {
  @override
  _MapsAllPageState createState() => _MapsAllPageState();
}

class _MapsAllPageState extends State<MapsAllPage> {
  late GoogleMapController mapController;
  Future<ModelKampus>? _kampusFuture;

  @override
  void initState() {
    super.initState();
    _kampusFuture = fetchKampus();
  }

  Future<ModelKampus> fetchKampus() async {
    final response = await http.get(Uri.parse('http://192.168.169.194/kampus%20Apps/getKampus.php'));

    if (response.statusCode == 200) {
      return modelKampusFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Maps'),
      ),
      body: FutureBuilder<ModelKampus>(
        future: _kampusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            Set<Marker> markers = snapshot.data!.data.map((kampus) {
              return Marker(
                markerId: MarkerId(kampus.nama),
                position: LatLng(double.parse(kampus.lat), double.parse(kampus.long)),
                infoWindow: InfoWindow(
                  title: kampus.nama,
                ),
              );
            }).toSet();

            return GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-0.9142568000791951, 100.46612951317739), // Koordinat pusat peta
                zoom: 10,
              ),
              markers: markers,
            );
          }
        },
      ),
    );
  }
}
