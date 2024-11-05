import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/product/product_page.dart';
import 'package:green_public_mobile/provider/PlacemarkProvider.dart';
import 'package:provider/provider.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import '../../dto/ProductImage.dart';
import '../../provider/StoreProvider.dart';
import '../../dto/TreeImage.dart';
import '../../provider/TreeProvider.dart';
import 'package:flutter/material.dart' as flutter;

class StoresDetailsPage extends StatefulWidget {
  const StoresDetailsPage({Key? key}) : super(key: key);

  @override
  State<StoresDetailsPage> createState() => _StoresDetailsPageState();
}

class _StoresDetailsPageState extends State<StoresDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (BuildContext context, StoreProvider storeProvider,
          Widget? child) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                child: flutter.Image.network(
                  storeProvider.currentStore.profilePhoto.url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 0.90,
                builder: (BuildContext context,
                    ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8.0,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: flutter.Image.network(
                                  storeProvider.currentStore
                                      .profilePhoto.url,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      storeProvider.currentStore.storeName,
                                      style: const flutter.TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                                  Point(latitude: storeProvider
                                                      .currentStore.latitude,
                                                      longitude: storeProvider
                                                          .currentStore
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
                                    Row(
                                      children: [
                                        Text(
                                          "${storeProvider.currentStore.openDays
                                              .first} - ${storeProvider
                                              .currentStore.openDays.last}",
                                          style: const flutter.TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "/ ${storeProvider.currentStore
                                              .openingAt} - ${storeProvider
                                              .currentStore.closingAt}",
                                          style: const flutter.TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            storeProvider.currentStore.storeDescription,
                            style: const flutter.TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.blueGrey),
                              const SizedBox(width: 8),
                              Text(storeProvider.currentStore.phoneNumber),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                  Icons.location_on, color: Colors.blueAccent),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  storeProvider.currentStore.address,
                                  style: const flutter.TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Consumer<StoreProvider>(
                            builder: (BuildContext context, StoreProvider value,
                                Widget? child) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            value.select(true);
                                          });
                                        },
                                        child: Container(
                                          decoration:  BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: value.isSelected ? Colors.black : Colors.black45,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          width: 198,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Trees",
                                                style: flutter.TextStyle(
                                                  color: value.isSelected ? Colors.black : Colors.black45,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            value.select(false);
                                          });
                                        },
                                        child: Container(
                                          decoration:  BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: !value.isSelected ? Colors.black : Colors.black45,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          width: 198,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Care products",
                                                style: flutter.TextStyle(
                                                  color: !value.isSelected ? Colors.black : Colors.black45,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Icon(Icons.search_sharp, size: 30,
                                  color: Colors.black45),
                              SizedBox(width: 8),
                              Text("Search", style: flutter.TextStyle(
                                  color: Colors.black45, fontSize: 25)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Consumer<StoreProvider>(
                            builder: (BuildContext context, StoreProvider value,
                                Widget? child) {
                              return FutureBuilder(
                                future: value.isSelected
                                    ? Provider
                                    .of<TreeProvider>(context,
                                    listen: false)
                                    .treeImageFutureList : Provider
                                    .of<StoreProvider>(context, listen: false)
                                    .productFutureList,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text(
                                        'Error: ${snapshot.error}'));
                                  } else if (snapshot.hasData) {
                                    if (value.isSelected) {
                                      List<TreeImage> images = snapshot
                                          .data as List<TreeImage>;
                                      return buildImageGrid(images);
                                    } else {
                                      List<ProductImage> products = snapshot
                                          .data as List<ProductImage>;
                                      return buildProductGrid(products);
                                    }
                                  } else {
                                    return const Center(
                                        child: Text("No data available."));
                                  }
                                },
                              );
                            },

                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildImageGrid(List<TreeImage> images) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        TreeImage image = images[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: flutter.Image(
                  image: image.treeImage.image,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      image.treeName,
                      style: const flutter.TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Tooltip(
                      message: image.description,
                      child: Text(
                        image.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const flutter.TextStyle(fontSize: 10.5),
                      ),
                    ),
                    Text(
                      "${image.price.toStringAsFixed(2)} Azn",
                      style: const flutter.TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildProductGrid(List<ProductImage> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductImage product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(productImage: product),));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  child: flutter.Image(
                    image: product.image.image,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: const flutter.TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Tooltip(
                        message: product.description,
                        child: Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const flutter.TextStyle(fontSize: 10.5),
                        ),
                      ),
                      Text(
                        product.price,
                        style: const flutter.TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}