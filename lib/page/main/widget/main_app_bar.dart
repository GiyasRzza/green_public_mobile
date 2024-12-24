import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import '../../../dto/StoreImage.dart';
import '../../../dto/TreeImage.dart';
import '../../../provider/PlacemarkProvider.dart';
import '../../../provider/StoreProvider.dart';
import '../../../provider/TreeProvider.dart';
import '../../../provider/WeatherProvider.dart';
import '../../register/store_details_page.dart';
import '../../tree/tree_details_page.dart';
import 'package:flutter/material.dart' as flutter;
class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (BuildContext context, WeatherProvider value, Widget? child) {
        return  Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: flutter.Image.asset(
                "images/homePageBg.png",
                width: double.infinity,
                fit: BoxFit.fill,

              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                child: Opacity(
                  opacity: 0.68,
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child:  Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 13.0, right: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                value.weatherScreen.name,
                                style: const flutter.TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                value.weatherScreen.localDateTime,
                                style: const flutter.TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                value.weatherScreen.temperatureC,
                                style: const flutter.TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreenAccent,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                value.weatherScreen.weatherConditionText,
                                style: const flutter.TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 1,
                          bottom: -5,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: flutter.Image.asset(
                                "images/cloudy.png",
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 65.0, left: 10),
                  child: SizedBox(child: flutter.Image.asset("images/welcome.png")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(child: flutter.Image.asset("images/text.png")),
                ),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         _storesBottomSheet(context);
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.only(top: 220, left: 17.0),
                //         child: SizedBox(child: flutter.Image.asset("images/Link.png")),
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         _advicesBottomSheet(context);
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.only(top: 220, left: 60),
                //         child: SizedBox(child: flutter.Image.asset("images/Link2.png")),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        );
      },
    );
  }
  void _storesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.all(16.0),
          child: Consumer<StoreProvider>(
            builder: (BuildContext context, StoreProvider value, Widget? child) {
              return  Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_back),
                        const SizedBox(height: 16.0),
                        if (!value.isSearch)
                          const Text(
                            'Stores',
                            style: flutter.TextStyle(fontSize: 20.0),
                          ),
                        const SizedBox(height: 16.0),
                        if (value.isSearch)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    value.getSearch(false);
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (query) {
                                value.searchTreesInImages(query);
                              },
                            ),
                          ),
                        ),
                        if (!value.isSearch)
                          IconButton(
                            icon:  const Icon(Icons.search_sharp),
                            onPressed: () {
                              value.getSearch(true);
                            },
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<StoreImage>>(
                      future:value.isSearch? value.filteredStoreImageListBottom :value.storeImageFutureListBottom,
                      builder: (BuildContext context, AsyncSnapshot<List<StoreImage>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text("Error loading stores"));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("No stores available"));
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final storeImage = snapshot.data![index];
                              return InkWell(
                                onTap: () {
                                  Provider.of<StoreProvider>(context, listen: false)
                                      .findStoreById(storeImage.id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const StoresDetailsPage()),
                                  );
                                },
                                child: SizedBox(
                                  height: 100,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    color: Colors.white12.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: flutter.Image(
                                              image: storeImage.storeImage.image,
                                              fit: BoxFit.cover,
                                              width: 120,
                                              height: 130,
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  storeImage.storeName,
                                                  style: const flutter.TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const Text(
                                                  "South Roosevelt LaneMuneledi.",
                                                  style: flutter.TextStyle(color: Colors.black45),
                                                ),

                                                Consumer<PlacemarkProvider>(
                                                  builder: (BuildContext context,
                                                      PlacemarkProvider value,
                                                      Widget? child) {
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .end,
                                                      children: [
                                                        Text(
                                                          "${value.distanceBetweenPointsOnRoute(
                                                              Point(latitude: storeImage
                                                                  .latitude,
                                                                  longitude: storeImage

                                                                      .longitude)).toStringAsFixed(2)} km",
                                                          style: const flutter.TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },

          ),
        );
      },
    );
  }

  void _advicesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.88,
          padding: const EdgeInsets.all(16.0),
          child: Consumer<TreeProvider>(
            builder: (BuildContext context, TreeProvider value, Widget? child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.arrow_back),
                            if (!value.isSearch)
                              const Text(
                                'Advices',
                                style: flutter.TextStyle(fontSize: 20.0),
                              ),
                            if (value.isSearch)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          value.getSearch(false);
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    onChanged: (query) {
                                      value.searchTreesInImages(query);
                                    },
                                  ),
                                ),
                              ),
                            if (!value.isSearch)
                              IconButton(
                                icon: const Icon(Icons.search_sharp),
                                onPressed: () {
                                  value.getSearch(true);
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 100.0,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: value.index == 1 ? Colors.black : Colors.black45,
                                    width:value.index == 1 ? 1.0:1.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Tree species",
                                    style: flutter.TextStyle(
                                      color: value.index == 1 ? Colors.green[900] : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                value.getIndex(1);
                              },
                            ),

                            const SizedBox(height: 16.0),
                            GestureDetector(
                              child: Container(
                                width: 130.0,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: value.index == 2 ? Colors.black : Colors.black45,
                                    width:value.index == 2 ? 1.0:1.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Planting process",
                                    style: flutter.TextStyle(
                                      color: value.index == 2 ? Colors.green[900] : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                value.getIndex(2);
                              },
                            ),

                            const SizedBox(height: 16.0),
                            GestureDetector(
                              child: Container(
                                width: 150.0,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: value.index == 3 ? Colors.black : Colors.black45,
                                    width:value.index == 3 ? 1.0:1.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Maintenance steps",
                                    style: flutter.TextStyle(
                                      color: value.index == 3 ? Colors.green[900] : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                value.getIndex(3);
                              },
                            )

                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<TreeImage>>(
                      future: value.isSearch? value.filteredTreeImageListBottom :value.treeImageFutureListBottom,
                      builder: (BuildContext context, AsyncSnapshot<List<TreeImage>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          List<TreeImage> treeImages = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: treeImages.length,
                            itemBuilder: (context, index) {
                              TreeImage treeImage = treeImages[index];
                              return InkWell(
                                onTap: () {
                                  Provider.of<TreeProvider>(context, listen: false).findTreeById(treeImage.id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TreeDetailsPage()),
                                  );
                                },
                                child: SizedBox(
                                  height: 220,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    color: Colors.white12.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(16.0),
                                              child: flutter.Image(
                                                image: treeImage.treeImage.image,
                                                fit: BoxFit.cover,
                                                width: 180,
                                                height: 180,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 16.0),
                                                  Text(
                                                    treeImage.treeName,
                                                    style: const flutter.TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 13.0),
                                                  SizedBox(
                                                    width: 175,
                                                    child: Tooltip(
                                                      message: treeImage.description,
                                                      child: Text(
                                                        treeImage.description,
                                                        overflow: TextOverflow.clip,
                                                        style: const flutter.TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 40.0),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: flutter.Image.asset(
                                                          "images/flower1.png",
                                                          fit: BoxFit.cover,
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: flutter.Image.asset(
                                                          "images/sun-2 1.png",
                                                          fit: BoxFit.cover,
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: flutter.Image.asset(
                                                          "images/rain 1.png",
                                                          fit: BoxFit.cover,
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: flutter.Image.asset(
                                                          "images/Group.png",
                                                          fit: BoxFit.cover,
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("No data available"));
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }


}
