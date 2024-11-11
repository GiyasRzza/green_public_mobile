import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/register/sign_in_page.dart';
import '../../map/map_page.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int currentPageIndex = 0;

  void _showFloatingMenu() {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuItem(Icons.favorite, "Make a donation"),
                  const SizedBox(height: 10),
                  _buildMenuItem(Icons.card_giftcard, "Give a tree as gift"),
                  CustomPaint(
                    painter: InvertedTrianglePainter(),
                    child: const SizedBox(
                      height: 10,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _buildMenuItem(IconData icon, String label) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    currentPageIndex = 0;
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
              MaterialPageRoute(builder: (context) => const SignInPage())
          );
        }
        if (index == 2) {
          _showFloatingMenu();
        }
      },
      indicatorColor: Colors.transparent,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/HomeS.png")),
          icon: ImageIcon(AssetImage("images/Home.png")),
          label: "Home",
        ),
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/LocationS.png")),
          icon: ImageIcon(AssetImage("images/Location.png")),
          label: 'Map',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.cancel_sharp, color: Colors.black, size: 60),
          icon: Icon(Icons.add_circle, color: Colors.black, size: 60),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/EventS.png")),
          icon: ImageIcon(AssetImage("images/Event.png")),
          label: 'Event',
        ),
        NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/ProfileS.png")),
          icon: ImageIcon(AssetImage("images/Profile.png")),
          label: 'Profile',
        ),
      ],
    );
  }
}

class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(InvertedTrianglePainter oldDelegate) => false;
}