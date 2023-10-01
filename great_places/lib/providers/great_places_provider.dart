import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place_model.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  // Manda buscar os lugares
  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');

    _items = dataList
        .map((e) => Place(
              id: e['id'],
              title: e['title'],
              image: File(e['image']),
              location: PlaceLocation(
                latitude: e['lat'],
                longitude: e['lng'],
                address: e['address']
              ),
            ))
        .toList();

    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address),
      image: image,
    );

    _items.add(newPlace);

    // Inserir no banco de dados e na tabela indicada e ja criada
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': position.latitude,
      'lng': position.longitude,
      'address': address,
    });

    notifyListeners();
  }
}
