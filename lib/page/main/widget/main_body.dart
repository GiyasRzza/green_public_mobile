import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/donation/donation_page.dart';
import 'package:green_public_mobile/provider/PlacemarkProvider.dart';
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
                        "Donations",
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
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int data) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            color: Colors.grey[200],
                            child: SizedBox(
                              width: 200,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(
                                      'images/homePageBg.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    right: 10,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        data == 0
                                            ? const Text(
                                          'Ministry of Ecology and Natural Resources',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                            : const Text(
                                          'Central Botanical Garden',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const ImageIcon(
                                              AssetImage("images/TreeEvergreen.png"),
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            const Text("15.0",style: TextStyle(
                                              color: Colors.white
                                            ),),
                                            const SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () {

                                                if(data==0){
                                                  Provider.of<PlacemarkProvider>(context, listen: false).setNgo("Ministry of Ecology and Natural Resources");
                                                }
                                                if(data==1){
                                                  Provider.of<PlacemarkProvider>(context, listen: false).setNgo("Central Botanical Garden");
                                                }
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => const DonationPage(
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.horizontal(
                                                    left: Radius.circular(25),
                                                    right: Radius.circular(25),
                                                  ),
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 20,
                                                color: Colors.black,
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
