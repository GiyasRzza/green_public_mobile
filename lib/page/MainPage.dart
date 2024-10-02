
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:green_public_mobile/dto/StoreImage.dart';
import 'package:green_public_mobile/dto/TreeVideo.dart';
import 'package:green_public_mobile/page/VideoPlayerScreen.dart';
import 'package:green_public_mobile/provider/StoreProvider.dart';
import 'package:green_public_mobile/provider/WeatherProvider.dart';
import 'package:provider/provider.dart';
import '../dto/TreeImage.dart';
import '../provider/TreeProvider.dart';
import 'StoresDetailsPage.dart';
import 'TreeDetailsPage.dart';
import 'map_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with SingleTickerProviderStateMixin{
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(400),
        child: Consumer<WeatherProvider>(
          builder: (BuildContext context, WeatherProvider value, Widget? child) {
            return  Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Image.asset(
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
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 8.0,left: 13.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Text(value.weatherScreen.region
                                      ,style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                      textAlign: TextAlign.left,
                                    ),
                                  Text(value.weatherScreen.localDateTime,style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("${value.weatherScreen.temperatureC} C",style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightGreenAccent,
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(value.weatherScreen.weatherConditionText,style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 13.0,left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        image: value.weatherScreen.weatherConditionIcon.image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  // Text("Change of rain :${value.weatherScreen.precip_mm}"
                                  //   ,style: const TextStyle(
                                  //     fontSize: 15,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.lightGreenAccent,
                                  //   ),
                                  // ),
                                ],
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
                      child: SizedBox(child: Image.asset("images/welcome.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SizedBox(child: Image.asset("images/text.png")),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _storesBottomSheet(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 220, left: 18.0),
                            child: SizedBox(child: Image.asset("images/Link.png")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _advicesBottomSheet(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 220, left: 60),
                            child: SizedBox(child: Image.asset("images/Link2.png")),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              // TreeApis.getTrees();
                              // getCurrentLocation();
                            },
                            child: const Text("Stores", style: TextStyle(color: Colors.black26, fontSize: 15),)

                        ),
                        const Text("See all", style: TextStyle(color: Colors.black26, fontSize: 15),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SizedBox(
                        height: 150,
                        child: Consumer<StoreProvider>(
                          builder: (BuildContext context, StoreProvider value, Widget? child) {
                            return  FutureBuilder<List<StoreImage>>(
                              future: value.getStoreImageListFuture,
                              builder: (BuildContext context, AsyncSnapshot<List<StoreImage>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(child: Text(""));
                                }
                                else if(snapshot.hasData){
                                  final storeImages = snapshot.data!;
                                  return   GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 20.0,
                                    ),
                                    itemCount: storeImages.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final storeImage = storeImages[index];
                                      return InkWell(
                                        onTap: () {
                                          Provider.of<StoreProvider>(context, listen: false).findStoreById(storeImage.id);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const StoresDetailsPage(),));
                                        },
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height:100,
                                              width: 350,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child: Image(
                                                  image: storeImage.storeImage.image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 40,
                                              left: 0,
                                              right: 0,
                                              child: Text(
                                                storeImage.storeName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  // Adjust the style as needed
                                                ),
                                                textAlign: TextAlign.center, // Center the text
                                              ),
                                            ),
                                          ],
                                        ),
                                      );

                                    },
                                  );;
                                }
                                else {
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                            );
                          },

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Advices", style: TextStyle(color: Colors.black26, fontSize: 15),),
                        Text("See all", style: TextStyle(color: Colors.black26, fontSize: 15),)
                      ],
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    height: 200,
                    child: Consumer<TreeProvider>(
                      builder: (BuildContext context, TreeProvider value, Widget? child) {
                        return   FutureBuilder<List<TreeImage>>(
                          future: value.treeImageFutureList,
                          builder: (BuildContext context, AsyncSnapshot<List<TreeImage>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Err: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              List<TreeImage> treeImages = snapshot.data!;
                              return GridView.builder(
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemCount: treeImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TreeImage treeImage = treeImages[index];
                                  return InkWell(
                                    onTap: () {
                                      Provider.of<TreeProvider>(context, listen: false).findTreeById(treeImage.id);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TreeDetailsPage(),));
                                    },
                                    child: SizedBox(
                                      height: 250,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        color: Colors.white12.withOpacity(0.8),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                height: 100,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  child: Image(
                                                    image: treeImage.treeImage.image,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  treeImage.treeName,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Tooltip(
                                                  message: treeImage.description,
                                                  child: Text(
                                                    treeImage.description,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    softWrap: true,
                                                    overflow: TextOverflow.visible,
                                                  ),
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
                            } else {
                              return const Center(child: Text('Data Empty'));
                            }
                          },
                        );
                      },

                    ),
                  ),
                ),

                ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                     const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Videos", style: TextStyle(color: Colors.black26, fontSize: 15),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SizedBox(
                        height: 200,
                        child: Consumer<TreeProvider>(
                          builder: (BuildContext context, TreeProvider value, Widget? child) {
                            return      FutureBuilder<List<TreeVideo>>(
                              future: value.treeVideoFutureList,
                              builder: (BuildContext context, AsyncSnapshot<List<TreeVideo>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('An error occurred: ${snapshot.error}'));
                                } else if (snapshot.hasData && snapshot.data != null) {
                                  List<TreeVideo> treeVideos = snapshot.data!;
                                  return GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    reverse: false,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10.0,
                                    ),
                                    itemCount: treeVideos.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      TreeVideo treeVideo = treeVideos[index];
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return VideoPlayerScreen(videoUrl: treeVideo.videoUrl);
                                            },
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(30.0),
                                                clipBehavior: Clip.hardEdge,
                                                child: Image.network(
                                                  treeVideo.videoPreview,
                                                  gaplessPlayback: true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                              top: 10.0,
                                              left: 10.0,
                                              child: Icon(
                                                Icons.play_circle_filled,
                                                size: 30.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),


                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            );
                          },
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapPage())
            );
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
  void _storesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.85,
          padding: const EdgeInsets.all(16.0),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(height: 16.0),
                    Text(
                      'Stores',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 16.0),
                    Icon(Icons.search_sharp),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<StoreImage>>(
                  future: Provider.of<StoreProvider>(context, listen: false).storeImageFutureList,
                  builder: (BuildContext context, AsyncSnapshot<List<StoreImage>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text(""));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text(""));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final storeImage = snapshot.data![index];

                          return InkWell(
                            onTap: () {
                              Provider.of<StoreProvider>(context, listen: false).findStoreById(storeImage.id);
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
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: Image(
                                          image: storeImage.storeImage.image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              storeImage.storeName,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Text(
                                              "South Roosevelt LaneMuneledi.",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            const Text(
                                              "3.41 km.",
                                              style: TextStyle(color: Colors.black),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
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
              )

            ],
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
          height: MediaQuery.of(context).size.height*0.85,
          padding: const EdgeInsets.all(16.0),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(height: 16.0),
                        Text(
                          'Advices',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 16.0),
                        Icon(Icons.search_sharp),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100.0,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),
                          child: const Center(
                            child: Text("Tree species"),
                          ),
                        ),

                        const SizedBox(height: 16.0),
                        Container(
                          width: 130.0,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),
                          child: const Center(
                            child: Text("Planting process"),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          width: 130.0,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),
                          child: const Center(
                            child: Text("Maintenance steps"),
                          ),
                        ),


                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<TreeProvider>(
                  builder: (BuildContext context, TreeProvider value, Widget? child) {
                    return FutureBuilder<List<TreeImage>>(
                      future: value.treeImageFutureList,
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TreeDetailsPage(),));
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
                                            Image(
                                             image:  treeImage.treeImage.image,
                                              fit: BoxFit.cover,
                                              width: 180,
                                              height: 180,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 16.0),
                                                  Text(
                                                    treeImage.treeName,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 13.0),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 175,
                                                      child: Tooltip(
                                                        message: treeImage.description,
                                                        child: Text(
                                                          treeImage.description,
                                                          overflow: TextOverflow.clip,
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset(
                                                          "images/frame1.png",
                                                          fit: BoxFit.cover,
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset(
                                                          "images/Light.png",
                                                          fit: BoxFit.cover,
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset(
                                                          "images/frame2.png",
                                                          fit: BoxFit.cover,
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset(
                                                          "images/snow.png",
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
                          return const Center(child: Text(""));
                        }
                      },
                    );
                  },
                ),


              )
            ],
          ),
        );
      },
    );
  }
}
