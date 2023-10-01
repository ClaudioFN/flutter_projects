import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      latitude: 37.422131,
      longitude: -122.084801,
    ),
    this.isReadOnly = false,
  });

  final PlaceLocation initialLocation;
  final bool isReadOnly;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPostion;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPostion = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione'),
        actions: [
          if(!widget.isReadOnly)
          IconButton(onPressed: _pickedPostion == null ? null : () {
            Navigator.of(context).pop(_pickedPostion);
          }, icon: Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 14,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: (_pickedPostion == null && !widget.isReadOnly)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('p1'),
                  position: _pickedPostion ?? widget.initialLocation.toLatLng(),
                ),
              },
      ),
    );
  }
}
