import 'package:flutter/material.dart';

import '../../main/main_page.dart';

class DonationSuccessDialog extends StatelessWidget {
  const DonationSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Image(image: AssetImage("images/Preparation.png"),),
          const SizedBox(height: 16),
          const Text(
            'Your donation has been received.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'When your trees are planted, information about its location and number will be sent to you.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Close',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
