import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as mapkit;
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import 'package:yandex_maps_mapkit_lite/src/bindings/image/image_provider.dart'
as image_provider;
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
      body: YandexMap(
        onMapCreated: (mapWindow) {
          _mapWindow = mapWindow;
          _addPlacemarks();
        },
      ),
    );
  }
  void _addPlacemarks() {
    final placemark = _mapWindow?.map.mapObjects.addPlacemark()
      ?..geometry =   const mapkit.Point(latitude: 25.2048, longitude: 55.2708)
    ..setIcon(image_provider.ImageProvider.fromImageProvider(const AssetImage("images/pin.png")));

  }
}