import 'package:flutter/material.dart';
import '../Model/kampus_Model.dart';
import 'maps_page.dart';

class KampusDetail extends StatelessWidget {
  final Datum kampus;

  KampusDetail({required this.kampus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kampus.nama),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.169.194/kampus%20Apps/gambar/${kampus.gambar}',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              kampus.nama,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              kampus.lokasi,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8.0),
            Text(
              kampus.profile,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.red),
                SizedBox(width: 8.0),
                Text('Lat: ${kampus.lat}, Long: ${kampus.long}'),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapsPage(
                        latitude: double.parse(kampus.lat),
                        longitude: double.parse(kampus.long),
                        namaKampus: kampus.nama,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.map),
                label: Text('Lihat di Peta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}