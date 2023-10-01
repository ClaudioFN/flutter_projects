import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {

  final Function? onSelectPosition;

  const LocationInputWidget(this.onSelectPosition, {Key? key}) : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPosition!(LatLng(
        locData.latitude!,
        locData.longitude!,
      ));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true, builder: (ctx) => MapScreen(),),
    );

    if (selectedPosition == null) {
      return;
    }

    _showPreview(selectedPosition.latitude!, selectedPosition.longitude!);

    /*final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: selectedPosition.latitude,
      longitude: selectedPosition.longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    print('selected: ${selectedPosition.latitude}');*/

    widget.onSelectPosition!(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text('Localização Não Informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Localização Atual'),
              onPressed: _getCurrentUserLocation,    // Passando a referencia para a funcao          
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Selecione no Mapa'),
              onPressed: _selectOnMap,              
            ),
          ],
        ),
      ],
    );
  }
}
