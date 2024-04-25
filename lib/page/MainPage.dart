import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../dto/TreeImage.dart';
import '../provider/TreeProvider.dart';
import 'StoresDetailsPage.dart';
import 'TreeDetailsPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        print(location.longitude);
        print(location.latitude);
      });
    } else {
      print("User denied permission to access device location.");
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(400), child: Stack(
        children: <Widget>[
          Image.asset("images/homePageBg.png",width: double.infinity,fit: BoxFit.fitWidth,),
          Padding(
            padding: const EdgeInsets.only(top: 85.0, left: 10),
            child: Opacity(
              opacity: 0.65,
              child: Container(
                width: 100, // İstenilen genişlik
                height: 100, // İstenilen yükseklik
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5), // Arka plan rengini ayarlayın
                  borderRadius: BorderRadius.circular(10.0), // Köşeleri yuvarlayın
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 65.0,left: 10),
                child: SizedBox(
                    child: Image.asset("images/welcome.png",)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(child: Image.asset("images/text.png",)),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _storesBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 190,left: 30.0),
                      child: SizedBox(child: Image.asset("images/Link.png",)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _advicesBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 190,left: 7),
                      child: SizedBox(child: Image.asset("images/Link2.png",)),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const StoresDetailsPage(),));
                        },
                        child: SizedBox(
                          height: 100,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Image.asset(
                                  "images/stores.png",
                                  fit:  BoxFit.fill,
                                ),
                              );
                            },
                          ),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TreeDetailsPage(),));
                    },
                    child: SizedBox(
                      height: 200,
                      child: FutureBuilder<List<TreeImage>>(
                        future: Provider.of<TreeProvider>(context, listen: false).treeImageFutureList,
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
                                return SizedBox(
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
                                );
                              },
                            );
                          } else {
                            return const Center(child: Text('Data Empty'));
                          }
                        },
                      ),
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
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              clipBehavior: Clip.hardEdge,
                              child: Image.asset(
                                "images/video.png",
                                fit:  BoxFit.contain,
                              ),
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
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StoresDetailsPage(),));

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
                                Image.asset(
                                  "images/stores.png",
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Green Public",style: TextStyle(color: Colors.black,fontSize: 20),),
                                      Text("South Roosevelt LaneMundelei.",style:
                                      TextStyle(color: Colors.black), ),
                                      Text("3.41 km.",style:
                                      TextStyle(color: Colors.black),softWrap: true,overflow:TextOverflow.visible ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
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
                                  Image.asset(
                                    "images/tree.png",
                                    fit:  BoxFit.cover,
                                    width: 180,
                                    height: 180,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16.0),
                                        const Align( child: Text("Oak Tree",style: TextStyle(color: Colors.black,fontSize: 20),)),
                                        const SizedBox(height: 16.0),
                                        const SizedBox(
                                          width: 175,
                                          child: Text(
                                            "Lorem ipsum dolor sit consectetur adipiscing elit..",
                                            overflow: TextOverflow.visible,
                                            style: TextStyle(color: Colors.black),
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
                                                fit:  BoxFit.cover,
                                                width: 25,
                                                height: 25,
                                              ),
                                            ),
                                            const SizedBox(height: 16.0),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "images/Light.png",
                                                fit:  BoxFit.cover,
                                                width: 25,
                                                height: 25,
                                              ),
                                            ),
                                            const SizedBox(height: 16.0),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "images/frame2.png",
                                                fit:  BoxFit.cover,
                                                width: 25,
                                                height: 25,
                                              ),
                                            ),
                                            const SizedBox(height: 16.0),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "images/snow.png",
                                                fit:  BoxFit.cover,
                                                width: 25,
                                                height: 25,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
