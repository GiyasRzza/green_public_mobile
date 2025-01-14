import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_public_mobile/dto/Placemark.dart';
import 'package:green_public_mobile/provider/WeatherProvider.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../../apis/PlacemarkApis.dart';
import '../../dto/ApiResponse.dart';
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
  late final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  var isOpen =false;

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
        isOpen=true;
    } else {
      provider.clearFilter();
      isOpen=true;
    }
  }

  void _clearSearch() {
    _searchController.clear();
    final provider = Provider.of<PlacemarkProvider>(context, listen: false);
    provider.clearFilter();
    FocusScope.of(context).unfocus();
  }

  void _addMarker(String id, LatLng position, String publishedAt) async {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(position, 15),
    );
  }

  void _addMarkerAll(String name, LatLng position, String publishedAt,String id) async {
    final customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(120, 120)),
      'images/pin.png',
    );

      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: position,
          icon: customIcon,
          onTap: () => _showPlacemarkBottomSheet(context, name, publishedAt, position,id),
        ),
      );
  }

  Future<void> _showPlacemarkBottomSheet(
      BuildContext context, String name, String publishedAt, LatLng position,String id) async {
    ApiResponse data= await  PlacemarkApis.getPlacemarkDetails(id.toString());
    List<UsersPermissionsUser> users= data.getUsersPermissionsUsers();
    String currentUser=users[0].companyName;
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
                        'images/hesenPark.jpeg',
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
                InkWell(
                  onTap: () {
                    showPlantedByCompaniesDialog(context,currentUser);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCompanyTile(currentUser, "1.000 Tree"),
                    
                    ],
                  ),
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
                      showChooseApplicationDialog(context);
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

  void showPlantedByCompaniesDialog(BuildContext context,String user) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Planted by companies",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'images/kapital_bank.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title:  Text(user),
                  trailing: const Text("1.000 Tree"),
                ),
                // ListTile(
                //   leading: ClipRRect(
                //     borderRadius: BorderRadius.circular(30),
                //     child: Image.asset(
                //       'images/azersun_logo.png',
                //       width: 40,
                //       height: 40,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   title: const Text("Azersun"),
                //   trailing: const Text("1.000 Tree"),
                // ),
                // ListTile(
                //   leading: ClipRRect(
                //     borderRadius: BorderRadius.circular(30),
                //     child: Image.asset(
                //       'images/app_bak.png',
                //       width: 40,
                //       height: 40,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   title: const Text("ABB"),
                //   trailing: const Text("1.000 Tree"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }


  void showChooseApplicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Choose the application",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset('images/waze_logo.png', width: 40),
                  title: const Text("Waze"),
                ),
                ListTile(
                  leading:
                  Image.asset('images/google_maps_logo.png', width: 40),
                  title: const Text("Google Maps"),
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (data) {

                    }),
                    const Text("Save your selection"),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompanyTile(String companyName, String treesPlanted) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Row(
           children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(30),
               child: Image.asset(
                 'images/kapital_bank.png',
                 width: 40,
                 height: 40,
                 fit: BoxFit.fill,
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                 companyName,
                 style: const TextStyle(
                   fontSize: 14,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ),
           ],
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
          Consumer2<WeatherProvider,PlacemarkProvider>(
            builder: (BuildContext context, WeatherProvider value, PlacemarkProvider placemarkProvider,Widget? child) {
              return  GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                  for (var placemark in placemarkProvider.firstPlaceMarks) {
                    setState(() {
                      _addMarkerAll(placemark.name, LatLng(placemark.latitude, placemark.longitude),
                          placemark.publishedAt,placemark.id.toString());
                    });
                  }


                },
                initialCameraPosition:  CameraPosition(
                  target: LatLng(value.location.latitude, value.location.longitude),
                  zoom: 12,
                ),


                markers: _markers,
                polylines: _polylines,
                trafficEnabled: true,
                myLocationEnabled: true,
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
                  Consumer<PlacemarkProvider>(
                    builder: (BuildContext context, PlacemarkProvider value, Widget? child) {
                      return SizedBox(
                        height: 51,
                        child: SearchField<String>(
                          suggestions: value.placemarks
                              .map((placemark) {
                            String placemarkName = placemark.name;
                            String searchText = _searchController.text.toLowerCase();
                            int matchIndex = placemarkName.toLowerCase().indexOf(searchText);
                            return SearchFieldListItem<String>(
                              placemarkName,
                              child: ListTile(
                                leading: const Icon(Icons.location_on_outlined),
                                title: RichText(
                                  text: TextSpan(
                                    text: placemarkName.substring(0, matchIndex),
                                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                                    children: [
                                      TextSpan(
                                        text: placemarkName.substring(matchIndex, matchIndex + searchText.length),
                                        style: const TextStyle(color: Colors.blue, fontSize: 14.0),
                                      ),
                                      TextSpan(
                                        text: placemarkName.substring(matchIndex + searchText.length),
                                        style: const TextStyle(color: Colors.black, fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Text(placemark.publishedAt),
                              ),
                            );
                          })
                              .toList(),
                          controller: _searchController,
                          searchInputDecoration: SearchInputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _clearSearch,
                            )
                                : null,
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          onSuggestionTap: (suggestion) {
                            final placemark = value.placemarks.firstWhere(
                                    (p) => p.name == suggestion.searchKey,
                                orElse: () => Placemark(
                                    id: 1,
                                    name: "",
                                    latitude: 1,
                                    longitude: 1,
                                    createdAt: "",
                                    updatedAt: "",
                                    publishedAt: "",
                                    documentId: ""));
                            if (placemark.name.isNotEmpty) {
                              final position = LatLng(placemark.latitude, placemark.longitude);
                              _addMarker(placemark.name, position, placemark.publishedAt);
                              _searchController.text = placemark.name;
                              FocusScope.of(context).unfocus();
                              value.clearFilter();
                            }
                          },
                          itemHeight: 100.0,
                          maxSuggestionsInViewPort: 6,
                          suggestionStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                          suggestionsDecoration: SuggestionDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(8.0),
                          ),
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
