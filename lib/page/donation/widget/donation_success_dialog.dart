import 'package:flutter/material.dart';

import '../payment_received_page.dart';

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
          const Icon(Icons.check_circle, color: Colors.green, size: 64),
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
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentReceivedPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text('Close',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
