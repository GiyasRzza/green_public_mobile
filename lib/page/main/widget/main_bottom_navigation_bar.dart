import 'package:flutter/material.dart';
import '../../map/map_page.dart';
import '../../register/profile_page.dart';
import '../../register/register_page.dart';
class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int currentPageIndex = 0;
  @override
  void initState() {
    currentPageIndex=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 20,
      surfaceTintColor: Colors.white,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
        if (index == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapPage())
          );
        }
        if (index == 4) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage())
          );
        }
      },
      indicatorColor: Colors.transparent,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/HomeS.png"),),
          icon: ImageIcon(AssetImage("images/Home.png"),),
          label: "Home",
        ),
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/LocationS.png"),),
          icon: ImageIcon(AssetImage("images/Location.png"),),
          label: 'Map',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.add_circle,color: Colors.black,size: 60,),
          icon: Icon(Icons.add_circle,color: Colors.black,size: 60,),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/EventS.png")),
          icon: ImageIcon(AssetImage("images/Event.png"),),
          label: 'Event',
        ),
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/ProfileS.png"),),
          icon: ImageIcon(AssetImage("images/Profile.png"),),
          label: 'Profile',
        ),
      ],
    );
  }
}
