import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/donation/donation_page.dart';
import 'package:green_public_mobile/page/donation/gift_tree_page.dart';
import 'package:green_public_mobile/page/main/main_page.dart';
import 'package:green_public_mobile/page/register/sign_in_page.dart';
import '../../map/map_page.dart';

class MainBottomNavigationBar extends StatefulWidget {
   int currentPageIndex;
   MainBottomNavigationBar({super.key,  required this.currentPageIndex});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  bool isMenuOpen = false;
  void _showFloatingMenu() {
    setState(() {
      isMenuOpen = true;
    });

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
                  GestureDetector(child: _buildMenuItem(Icons.favorite, "Make a donation"), onTap: () =>  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DonationPage())
                  ),),
                  const SizedBox(height: 10),
                  GestureDetector(child: _buildMenuItem(Icons.card_giftcard, "Give a tree as gift"),
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GiftTreePage()));
                  }, ),
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
    ).then((_) {
      setState(() {
        isMenuOpen = false;
      });
    });
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
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 20,
      surfaceTintColor: Colors.white,
      onDestinationSelected: (int index) {
        if (widget.currentPageIndex != index) {
          setState(() {
            widget.currentPageIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapPage()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          } else if (index == 2) {
            _showFloatingMenu();
          }
        }

      },
      indicatorColor: Colors.transparent,
      selectedIndex:  widget.currentPageIndex,
      destinations: <Widget>[
        const NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/HomeS.png")),
          icon: ImageIcon(AssetImage("images/Home.png")),
          label: "Home",
        ),
        const NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/LocationS.png")),
          icon: ImageIcon(AssetImage("images/Location.png")),
          label: 'Map',
        ),
        NavigationDestination(
          selectedIcon: isMenuOpen
              ? const Icon(Icons.cancel_sharp, color: Colors.black, size: 60)
              : const Icon(Icons.add_circle, color: Colors.black, size: 60),
          icon: isMenuOpen
              ? const Icon(Icons.cancel_sharp, color: Colors.black, size: 60)
              : const Icon(Icons.add_circle, color: Colors.black, size: 60),
          label: '',
        ),
        const NavigationDestination(
          selectedIcon: ImageIcon(AssetImage("images/EventS.png")),
          icon: ImageIcon(AssetImage("images/Event.png")),
          label: 'Event',
        ),
        const NavigationDestination(
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