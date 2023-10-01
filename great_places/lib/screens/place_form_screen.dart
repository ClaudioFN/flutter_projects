import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:great_places/widgets/image_input_widget.dart';
import 'package:great_places/widgets/location_input_widget.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPostion;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPostion = position;
    });
  }

  bool _isValidForm() {
    print(
        'valores aqui !!!!!!!!!! ${_titleController.text.isNotEmpty} - $_pickedImage - $_pickedPostion');
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPostion != null;
  }

  void _submitForm() {
    if (!_isValidForm()) {
      return;
    }

    Provider.of<GreatPlacesProvider>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPostion!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Local'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ImageInputWidget(_selectImage),
                  SizedBox(
                    width: 20,
                  ),
                  LocationInputWidget(_selectPosition),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Colors.black,
              elevation: 100,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _isValidForm() ? _submitForm : null,
          ),
        ],
      ),
    );
  }
}
