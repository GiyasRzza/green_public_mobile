import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_public_mobile/provider/WeatherProvider.dart';
import 'package:provider/provider.dart';
import '../../provider/PlacemarkProvider.dart';
import '../main/widget/main_bottom_navigation_bar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController _searchController = TextEditingController();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

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
    FocusScope.of(context).unfocus();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarker(String id, LatLng position, String publishedAt) async {
    final customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(120, 120)),
      'images/pin.png',
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: position,
          icon: customIcon,
          onTap: () => _showPlacemarkBottomSheet(context, id, publishedAt, position),
        ),
      );
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(position, 15),
    );
  }

  void _addPolyline(LatLng start, LatLng end) {
    final String polylineId = 'route_${start.latitude}_${start.longitude}_${end.latitude}_${end.longitude}';

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId(polylineId),
          points: [start, end],
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  void _showPlacemarkBottomSheet(
      BuildContext context, String name, String publishedAt, LatLng position) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'images/hesenPark.jpeg', // Park resmi
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Azerbaijan, Nakhchivan 7000",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Your new trees have a long life ahead of them, and they deserve to start it under ideal conditions. Our Probiotic Root Stimulant contains the most complete range of natural products available, to make that happen.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  "Planted by companies",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCompanyTile("Kapital Bank", "1.000 Tree"),
                    _buildCompanyTile("Azersun", "1.000 Tree"),
                    _buildCompanyTile("ABB", "1.000 Tree"),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.directions_walk,
                            size: 18, color: Colors.green),
                        const SizedBox(width: 5),
                        Text(
                          "1.6 km",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 18, color: Colors.green),
                        const SizedBox(width: 5),
                        Text(
                          "5 min",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time_filled,
                            size: 18, color: Colors.green),
                        const SizedBox(width: 5),
                        Text(
                          "Open - 24 hours",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Route",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompanyTile(String companyName, String treesPlanted) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            companyName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            treesPlanted,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<WeatherProvider>(
            builder: (BuildContext context, WeatherProvider value, Widget? child) {
              return  GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition:  CameraPosition(
                  target: LatLng(value.location.latitude, value.location.longitude),
                  zoom: 13,
                ),
                markers: _markers,
                polylines: _polylines,
                trafficEnabled: true,
              );
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
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _clearSearch,
                            )
                                : null,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
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
                                final position = LatLng(
                                    placemark.latitude, placemark.longitude);
                                _addMarker(placemark.name, position,
                                    placemark.publishedAt);
                                _searchController.text = placemark.name;
                                FocusScope.of(context).unfocus();
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
      bottomNavigationBar: MainBottomNavigationBar(currentPageIndex: 1),
    );
  }
}
