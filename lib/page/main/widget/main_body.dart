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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Events",
                        style: TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: Colors.grey[200],
                            child: const SizedBox(
                              width: 200,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Event Title",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Event description goes here. More details can be added.",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.event, size: 14, color: Colors.black54),
                                        SizedBox(width: 4),
                                        Text(
                                          "03.04.2024 (10:00)",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                      Text(
                        "Advices",
                        style: TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                      height: 250,
                      child: Consumer<TreeProvider>(
                        builder: (BuildContext context, TreeProvider value, Widget? child) {
                          return FutureBuilder<List<TreeImage>>(
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
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemCount: treeImages.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    TreeImage treeImage = treeImages[index];
                                    return InkWell(
                                      onTap: () {
                                        Provider.of<TreeProvider>(context, listen: false).findTreeById(treeImage.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const TreeDetailsPage()),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        color: Colors.grey[200],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child: Image(
                                                  width: 280,
                                                  height: 160,
                                                  image: treeImage.treeImage.image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0,top: 2),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      treeImage.treeName,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Tooltip(
                                                      message: treeImage.description,
                                                      child: Text(
                                                        treeImage.description,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
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
