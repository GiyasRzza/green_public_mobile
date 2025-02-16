import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:geolocator/geolocator.dart';
import 'package:green_public_mobile/dto/ApiResponse.dart';
import 'package:green_public_mobile/dto/Placemark.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/src/mapkit/geometry/geometry.dart'
as mapkit_geometry_geometry;
import '../apis/PlacemarkApis.dart';
class PlacemarkProvider extends ChangeNotifier {
  List<Placemark> firstPlaceMarks = [];
  List<Placemark> _filteredPlacemarks = [];
  Future<List<Placemark>> futurePlacemark = Future<List<Placemark>>.value([]);
  List<ApiResponse> placeMarkDetails=[];
  String _query = "";
  String selectedNgo="";
  List<Placemark> get placemarks => _filteredPlacemarks;
  String kmInstance="";
  var location;
  PlacemarkProvider()  {
    getCurrentLocation();
    getFromApiStores();
  }

  void setNgo(String ngo){
    selectedNgo=ngo;
    notifyListeners();
  }

  Future<void> getFromApiStores() async {
    List<Placemark> response = await PlacemarkApis.getPlacemarks();
    firstPlaceMarks.addAll(response);

    futurePlacemark.then((value) {
      value.addAll(response);
    },);
    notifyListeners();
  }

  UsersPermissionsUser getCurrentDetails(String id){

      UsersPermissionsUser user=UsersPermissionsUser(companyName: "empty");
      return user;
  }
  Future<void> getCurrentLocation() async {
    try {
      location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      notifyListeners();
    } catch (e) {
      print("errr: $e");
      location = null;
    }
  }
  Future<void> filterPlacemarks(String query) async {
    _query = query;
    if (query.isEmpty) {
      _filteredPlacemarks = [];
    } else {
      _filteredPlacemarks = firstPlaceMarks.where((placemark) =>
          placemark.name.toLowerCase().contains(query.toLowerCase())).toList();

      if (location != null) {
        for (var element in _filteredPlacemarks) {
          String km = distanceBetweenPointsOnRoute(Point(latitude: element.latitude, longitude: element.longitude)).toStringAsFixed(2);
          element.publishedAt = "$km km";
        }
      } else {
        print("Location null!");
      }
    }
    notifyListeners();
  }


  void clearFilter() {
    _query = "";
    _filteredPlacemarks = [];
    notifyListeners();
  }

  Widget highlightedText(String text) {
    if (_query.isEmpty) {
      return Text(text);
    }
    final matchIndex = text.toLowerCase().indexOf(_query.toLowerCase());
    if (matchIndex == -1) {
      return Text(text);
    }

    final startText = text.substring(0, matchIndex);
    final highlightedText = text.substring(matchIndex, matchIndex + _query.length);
    final endText = text.substring(matchIndex + _query.length);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: startText,
            style: const flutter.TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: highlightedText,
            style: const flutter. TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: endText,
            style: const flutter.TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
  double distanceBetweenPointsOnRoute(Point second) {
    if (location == null) {
      return 0.0;
    }
    Point first = Point(latitude: location!.latitude, longitude: location!.longitude);
    List<Point> points = [first, second];
    final polylineIndex = PolylineUtils.createPolylineIndex(mapkit_geometry_geometry.Polyline(points));

    final firstPosition = polylineIndex.closestPolylinePositionWithPriority(
      first,
      PolylineIndexPriority.ClosestToRawPoint,
      maxLocationBias: 1.0,
    )!;

    final secondPosition = polylineIndex.closestPolylinePositionWithPriority(
      second,
      PolylineIndexPriority.ClosestToRawPoint,
      maxLocationBias: 1.0,
    )!;

    return PolylineUtils.distanceBetweenPolylinePositions(mapkit_geometry_geometry.Polyline(points), firstPosition, secondPosition)/1000;
  }

}