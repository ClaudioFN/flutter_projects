import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places_provider.dart';
import 'package:great_places/utils/app_routes_util.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // para telas
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlacesProvider>(
                child: Center(
                  child: Text('Nenhum local cadastrado!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.itemByIndex(i).image),
                          ),
                          title: Text(greatPlaces.itemByIndex(i).title),
                          subtitle: Text(greatPlaces.itemByIndex(i).location!.address!),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.PLACE_DETAIL,
                              arguments: greatPlaces.itemByIndex(i),
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
