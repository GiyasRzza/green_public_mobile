import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/ProductImage.dart';
import '../../provider/StoreProvider.dart';

class ProductPage extends StatefulWidget {
  final ProductImage  productImage;
  const ProductPage({super.key, required this.productImage});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            child: Image(
              image: widget.productImage.image.image,
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
            initialChildSize: 0.7,
            minChildSize: 0.65,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.productImage.productName,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.productImage.price,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          text: widget.productImage.description,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: " more",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                print("More clicked!");
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Text("Other Products", style: TextStyle(
                              color: Colors.black, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Consumer<StoreProvider>(
                        builder: (BuildContext context, StoreProvider value,
                            Widget? child) {
                          return FutureBuilder(
                            future:   Provider
                                .of<StoreProvider>(context, listen: false)
                                .productFutureList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasData) {
                                List<ProductImage> products = snapshot
                                    .data as List<ProductImage>;
                                return buildProductGrid(products);
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
                child: Image(
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
                      style: const TextStyle(
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
                        style: const TextStyle(fontSize: 10.5),
                      ),
                    ),
                    Text(
                      product.price,
                      style: const TextStyle(
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
}
