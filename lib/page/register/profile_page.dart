import 'dart:io';
import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/main/widget/main_bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../provider/TreeProvider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TreeProvider>(
      builder: (BuildContext context, TreeProvider value, Widget? child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(color: const Color(0xFF3A5A40)),
              Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.white,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? const Icon(Icons.account_circle,
                                    color: Colors.grey, size: 40)
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          right: -1,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(Icons.edit, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Qiyas Rayev",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                  },
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.75,
                minChildSize: 0.75,
                maxChildSize: 0.75,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            top: 30,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.56666,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: const ListTile(
                                      contentPadding: EdgeInsets.all(12),
                                      leading: CircleAvatar(
                                        backgroundColor: Color(0xFF3A5A40),
                                        child: Icon(Icons.card_giftcard, color: Colors.white),
                                      ),
                                      title: Text("Gifted tree"),
                                      subtitle: Text("From: Nature Lovers"),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("03.04.2024"),
                                          SizedBox(height: 4),
                                          Icon(Icons.access_time, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            left: 5,
                            right: 5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 75,
                              width: 400,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 3),
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //   color: Colors.grey.withOpacity(0.3),
                                        //   spreadRadius: 2,
                                        //   blurRadius: 6,
                                        //   offset: const Offset(0, 3),
                                        // ),
                                      ],
                                    ),
                                    height: 65,
                                    width: 140,
                                    child: const Center(child: Text("Planted Tree")),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //   color: Colors.grey.withOpacity(0.3),
                                        //   spreadRadius: 2,
                                        //   blurRadius: 6,
                                        //   offset: const Offset(0, 3),
                                        // ),
                                      ],
                                    ),
                                    height: 65,
                                    width: 120,
                                    child: const Center(child: Text("Donations")),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    height: 65,
                                    width: 120,
                                    child: const Center(child: Text("Gifts")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          bottomNavigationBar:  MainBottomNavigationBar(currentPageIndex: 4,),
        );
      },
    );
  }
}
