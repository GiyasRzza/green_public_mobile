import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../apis/TreeApis.dart';
import '../../../dto/StoreImage.dart';
import '../../../dto/TreeImage.dart';
import '../../../dto/TreeVideo.dart';
import '../../../provider/StoreProvider.dart';
import '../../../provider/TreeProvider.dart';
import '../../register/store_details_page.dart';
import '../../tree/tree_details_page.dart';
import '../../video/video_player_page.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                            TreeApis.getTrees();
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
    );
  }
}
