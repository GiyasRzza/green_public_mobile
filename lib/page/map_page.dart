import 'package:flutter/material.dart';
import 'package:mappable_maps_mapkit_lite/mapkit.dart' as mapkit;
import 'package:mappable_maps_mapkit_lite/mappable_map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  mapkit.MapWindow? _mapWindow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MappableMap(
        onMapCreated: (mapWindow) {
          _mapWindow = mapWindow;
          _addPlacemarks();
        },
      ),
    );
  }
  void _addPlacemarks() {
    if (_mapWindow != null) {
      final places = [
        const mapkit.Point(latitude: 25.1982, longitude: 55.272758),
        const mapkit.Point(latitude: 25.2048, longitude: 55.2708),
        const mapkit.Point(latitude: 25.190, longitude: 55.275),
      ];
      for (var i = 0; i < places.length; i++) {
        final placemark = _mapWindow!.map.mapObjects.addPlacemark()
          ..geometry = places[i]
          ..setText("Place ${i + 1}")
          ..setTextStyle(
            const mapkit.TextStyle(
              size: 10.0,
              color: Colors.black,
              outlineColor: Colors.white,
              placement: mapkit.TextStylePlacement.Right,
              offset: 5.0,
            ),
          );
        // placemark.useCompositeIcon().setIcon(
        //     AssetImage("images/6388095.png"),
        //   const mapkit.IconStyle(
        //     anchor: mapkit.Point(0.5, 1.0),
        //     scale: 2.0,
        //   ),
        //   name: "marker_${i + 1}",
        // );
      }
    }
  }
}