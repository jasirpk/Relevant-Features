import 'package:flutter/material.dart';
import 'package:flutter_demo/model/google_maps.dart' as locations;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final Map<String, Marker> markers = {};
  late GoogleMapController mapController;

  Future<void> onMapcreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(
      () {
        markers.clear();
        for (final office in googleOffices.offices) {
          final marker = Marker(
            markerId: MarkerId(office.name),
            position: LatLng(office.lat, office.lng),
            infoWindow: InfoWindow(title: office.name, snippet: office.address),
          );
          markers[office.name] = marker;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps Sample App"),
        elevation: 2,
      ),
      body: GoogleMap(
        onMapCreated: onMapcreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        markers: markers.values.toSet(),
        // mapType: MapType.satellite,
      ),
    );
  }
}
