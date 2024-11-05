import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';

final class MapObjectTapListenerImpl implements MapObjectTapListener {
  final BuildContext context;
  MapObjectTapListenerImpl(this.context);
  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    print("salaaaaaaaaaaaaam");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text(""),
          actions: [
            TextButton(
              child: Text("Geri Al"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return true;
  }
}
