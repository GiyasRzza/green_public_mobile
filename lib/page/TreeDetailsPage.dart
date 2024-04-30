import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_public_mobile/provider/TreeProvider.dart';
import 'package:provider/provider.dart';

import 'VideoPlayerScreen.dart';

class TreeDetailsPage extends StatefulWidget {
  const TreeDetailsPage({Key? key}) : super(key: key);

  @override
  State<TreeDetailsPage> createState() => _TreeDetailsPageState();
}

class _TreeDetailsPageState extends State<TreeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TreeProvider>(
      builder: (BuildContext context, TreeProvider value, Widget? child) {
        return   Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(500),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  child: Image.network(
                    value.currentTree.pictureUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -60,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white.withOpacity(0.999),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 100,
                  ),
                ),

              ],
            ),
          ),
          body:  SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.currentTree.name, style:
                        const TextStyle(color: Colors.black, fontSize: 25)),
                          Text("${value.currentTree.price.toString()} AZN", style:
                        const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.currentTree.bestSeasons.length,
                        itemBuilder: (context, index) {
                          String season = value.currentTree.bestSeasons[index];
                          return SizedBox(
                            height: 60,
                            width: 100,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  season,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 10,right: 15,left: 15,bottom: 10),
                    child: Expanded(
                      child: Text(value.currentTree.description,overflow: TextOverflow.clip),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              "images/İcon.png",
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                         Column(
                          children: [
                            const Text("Watering",style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                            ),),
                             SizedBox(
                               width: 100,
                               height: 20,
                               child: Expanded(
                                 child: Text(value.currentTree.watering,
                                   overflow: TextOverflow.fade,
                                   maxLines: 3,
                                   softWrap: true,
                                 ),
                               ),
                             ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              "images/derph.png",
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                         Column(
                          children: [
                            const Text("Depth",style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                            ),),
                            SizedBox(
                              width: 100,
                              height: 20,
                              child: Expanded(
                                child: Text(value.currentTree.depth,
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0,left: 8.0,right: 20.0,top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0,left: 8.0,right: 8.0,top: 8.0),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              "images/sun.png",
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                         Column(
                          children: [
                            const Text("Light",style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                            ),),
                            SizedBox(
                              width: 100,
                              height: 20,
                              child: Expanded(
                                child: Text(value.currentTree.light,
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              "images/soil.png",
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                         Column(
                          children: [
                            const Text("Soil type",style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                            ),),
                            SizedBox(
                              width: 100,
                              height: 20,
                              child: Expanded(
                                child: Text(value.currentTree.soilType,
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Planting process",style: TextStyle(fontSize: 30),),
                        SizedBox(
                          height: 25,
                        ),
                        Text("1. Cleaning the site.",style: TextStyle(fontSize: 18),),
                        Text("2. Digging a hole..",style: TextStyle(fontSize: 18),),
                        Text("3. Obtaining the plant.",style: TextStyle(fontSize: 18),),
                        Text("4. Watering the seedling.",style: TextStyle(fontSize: 18),),
                        Text("5. Removing the plant from the pot.",style: TextStyle(fontSize: 18),),
                        Text("6. Placing the plant in the hole.",style: TextStyle(fontSize: 18),),
                        Text("7. Covering the roots with soil.",style: TextStyle(fontSize: 18),),
                        Text("8. Gently packing the soil around the tree.",style: TextStyle(fontSize: 18),),
                      ],),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return VideoPlayerScreen(videoUrl: value.currentTree.videoUrl);
                          },
                        );
                      },
                      child: SizedBox(
                        width: 400,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image.network(
                              value.currentTree.videoPreview,
                              gaplessPlayback: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
