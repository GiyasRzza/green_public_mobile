import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/main/main_page.dart';
import 'package:provider/provider.dart';

import '../../provider/TreeProvider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FState();
}

class _FState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TreeProvider>(
      builder: (BuildContext context, TreeProvider value, Widget? child) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                "images/firstPageLogo.png",
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.42,
                minChildSize: 0.42,
                maxChildSize: 0.42,
                builder: (context, scrollController) {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification) {
                      }
                      return true;
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          controller: scrollController,
                          children: [
                           Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Welcome to",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Green Public!",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[900],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta ipsum",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => const MainPage()));
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child:  Image.asset("images/nextButton.png",width: 60,height: 60,)
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
              ),
            ],
          ),
        );
      },
    );
  }
}
