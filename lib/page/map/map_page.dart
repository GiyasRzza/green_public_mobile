import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:provider/provider.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as mapkit;
import 'package:yandex_maps_mapkit_lite/src/bindings/image/image_provider.dart' as image_provider;
import 'package:yandex_maps_mapkit_lite/src/mapkit/animation.dart'
as mapkit_animation;
import '../../core/MapIconOnTap.dart';
import '../../provider/PlacemarkProvider.dart';
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  final TextEditingController _searchController = TextEditingController();
  mapkit.MapWindow? _mapWindow;

  int currentPageIndex = 2;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final provider = Provider.of<PlacemarkProvider>(context, listen: false);
    if (_searchController.text.isNotEmpty) {
      provider.filterPlacemarks(_searchController.text);
    } else {
      provider.clearFilter();
    }
  }

  void _clearSearch() {
    _searchController.clear();
    final provider = Provider.of<PlacemarkProvider>(context, listen: false);
    provider.clearFilter();
    moveCamera();
    FocusScope.of(context).unfocus();
  }

  void _addPlacemarks() {
    if (_mapWindow == null) {
      print("Map window not initialized.");
      return;
    }

    final listener = MapObjectTapListenerImpl(context);
    final cameraCallback = MapCameraCallback(onMoveFinished: (isFinished) {});
    final provider = Provider.of<PlacemarkProvider>(context, listen: false);
    final placemarks = provider.placemarks;

    if (placemarks.isNotEmpty) {
      final selectedPlacemark = placemarks.first;
      final latitude = selectedPlacemark.latitude;
      final longitude = selectedPlacemark.longitude;

  final  placemark=  _mapWindow?.map.mapObjects.addPlacemark()
        ?..geometry = mapkit.Point(latitude: latitude, longitude: longitude)
        ..visible=true
        ..setIconWithStyle(
          image_provider.ImageProvider.fromImageProvider(const AssetImage("images/pin.png")),
          const IconStyle(
            anchor: math.Point(1.0, 1.0),
            scale: 5.0,
            zIndex: 1.0,
          ),
        )

      ;
      _mapWindow?.map.moveWithAnimation(
        CameraPosition(
          Point(latitude: latitude, longitude: longitude),
          zoom: 20.0,
          azimuth: 0.0,
          tilt: 0.0,
          
        ),
        const mapkit_animation.Animation(AnimationType.Linear, duration: 1.0),
        cameraCallback: cameraCallback,
      );
      placemark?.addTapListener(listener);
    } else {
      print("No placemarks found for the search query.");
    }
  }
  moveCamera(){
    final provider = Provider.of<PlacemarkProvider>(context, listen: false);
    final location = provider.location;
    final cameraCallback = MapCameraCallback(onMoveFinished: (isFinished) {
    });
    _mapWindow?.map.moveWithAnimation(
        CameraPosition(
          Point(latitude: location.latitude, longitude: location.longitude),
          zoom: 10.0,
          azimuth: 0.0,
          tilt: 0.0,
        ),
        const mapkit_animation.Animation(AnimationType.Linear, duration: 1.0),
    cameraCallback: cameraCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (mapWindow) {
              _mapWindow = mapWindow;
            },
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle:  const flutter.TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            prefixIcon: const ImageIcon(AssetImage("images/Search.png")),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _clearSearch,
                            )
                                : null,
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Consumer<PlacemarkProvider>(
                    builder: (context, provider, child) {
                      final placemarks = provider.placemarks;
                      if (placemarks.isEmpty) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: placemarks.length,
                          itemBuilder: (context, index) {
                            final placemark = placemarks[index];
                            return ListTile(
                              leading: const Icon(Icons.location_on_outlined),
                              title: provider.highlightedText(placemark.name),
                              trailing: Text(placemark.publishedAt),
                              onTap: () {
                                  setState(() {
                                    _searchController.text = placemark.name;
                                  });
                                  FocusScope.of(context).unfocus();
                                _addPlacemarks();
                                provider.clearFilter();
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          if (index == 0) {
            Navigator.pop(context);
          }
        },
        indicatorColor: Colors.green,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage("images/home.png")),
            icon: ImageIcon(AssetImage("images/home.png")),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage("images/location.png")),
            icon: ImageIcon(AssetImage("images/location.png")),
            label: 'Location',
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage("images/globus.png")),
            icon: ImageIcon(AssetImage("images/globus.png")),
            label: 'Map',
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage("images/seller.png")),
            icon: ImageIcon(AssetImage("images/seller.png")),
            label: 'Seller',
          ),
        ],
      ),
    );
  }

}