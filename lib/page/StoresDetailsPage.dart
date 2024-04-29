import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dto/TreeImage.dart';
import '../provider/TreeProvider.dart';
import '../provider/StoreProvider.dart';

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
          body: Stack(
            children: [
              // Resim
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  child: Image.network(
                    value.currentStore.imageUrl,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 300, // Görselin yüksekliği
                  ),
                ),
              ),

              Positioned(
                top: 220,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  value.currentStore.imageUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              // Metin
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.currentStore.storeName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(
                                          "${value.currentStore.openDays.first} - ${value.currentStore.openDays.last}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "${value.currentStore.openingAt} - ${value.currentStore.closingAt}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      "${value.currentStore.distance} km",
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),

                          Text(
                            value.currentStore.storeDescription,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 16.0),

                          Row(
                            children: [
                              const Icon(Icons.phone, size: 20.0),
                              const SizedBox(width: 8.0),
                              Text(
                                value.currentStore.phoneNumber,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 20.0, color: Colors.blue),
                              const SizedBox(width: 8.0),
                              Text(
                                value.currentStore.address,
                                style: const TextStyle(fontSize: 16.0, color: Colors.blue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          // Arama kutusu
                          Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, size: 20.0, color: Colors.grey.shade600),
                                const SizedBox(width: 8.0),
                                const Text("Search"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // GridView
                          SizedBox(
                            height: 200,
                            child: FutureBuilder<List<TreeImage>>(
                              future: Provider.of<TreeProvider>(context, listen: false).treeImageFutureList,
                              builder: (BuildContext context, AsyncSnapshot<List<TreeImage>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
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
                                        height: 200,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12.0),
                                                child: Image(
                                                  image: treeImage.treeImage.image,
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Text(
                                                treeImage.treeName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                treeImage.description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(child: Text('No data available'));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
