import 'package:flutter/material.dart';
import 'package:green_public_mobile/provider/StoreProvider.dart';
import 'package:provider/provider.dart';

import '../dto/TreeImage.dart';
import '../provider/TreeProvider.dart';

class StoresDetailsPage extends StatefulWidget {
  const StoresDetailsPage({Key? key}) : super(key: key);

  @override
  State<StoresDetailsPage> createState() => _StoresDetailsPageState();
}

class _StoresDetailsPageState extends State<StoresDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (BuildContext context, StoreProvider value, Widget? child) {
        return Scaffold(
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
                    value.currentStore.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: -60,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white.withOpacity(0.99),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 100,
                  ),
                ),

              ],
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 600,
              child:  Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17.0),
                                  child: Image.network(
                                    value.currentStore.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          value.currentStore.storeName,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${value.currentStore.openDays.first} - ${value.currentStore.openDays.last}",
                                              softWrap: true,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                color: Colors.black26,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              " / ${value.currentStore.openingAt} - ${value.currentStore.closingAt}",
                                              softWrap: true,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                color: Colors.black26,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Text(
                                        "${value.currentStore.distance.toString()} km",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.currentStore.storeDescription,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(color: Colors.black, fontSize: 15)),
                                                     ),
                           ],
                         ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(value.currentStore.phoneNumber)
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on,color: Colors.blueAccent,),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(value.currentStore.address,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(color: Colors.blueAccent, fontSize: 15)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black45,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Trees",
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.black45, fontSize: 20),
                                ),
                              ),
                              const Text("Care products",
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.black45, fontSize: 20)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.search_sharp,size: 35,color: Colors.black45,),
                                ),
                                Text("Search",style: TextStyle(color:Colors.black45,fontSize: 25),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
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
                      ],
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
}
