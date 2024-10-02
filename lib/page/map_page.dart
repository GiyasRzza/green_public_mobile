import 'package:flutter/material.dart';
import 'package:mappable_maps_mapkit_lite/mapkit.dart';
import 'package:mappable_maps_mapkit_lite/mappable_map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapWindow? _mapWindow;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MappableMap(
        onMapCreated: (mapWindow) {
          _mapWindow = mapWindow;
        },
      ),
    );
  }
}
