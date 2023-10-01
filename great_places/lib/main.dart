import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes_util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
        ),
        home: PlacesListScreen(),
        routes: {AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
        AppRoutes.PLACE_DETAIL: (ctx) => PlaceDetailScreen()},
      ),
    );
  }
}
