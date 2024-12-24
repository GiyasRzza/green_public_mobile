import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/main/widget/main_app_bar.dart';
import 'package:green_public_mobile/page/main/widget/main_body.dart';
import 'package:green_public_mobile/page/main/widget/main_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(400),
      child: MainAppBar()),
      body: const MainBody(),
      bottomNavigationBar: MainBottomNavigationBar(currentPageIndex: 0,),
    );
  }
}
