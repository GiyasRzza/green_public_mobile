import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/donation/widget/donation_success_dialog.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  String? selectedNGO;
  String? plantingInterval;
  final TextEditingController amountController = TextEditingController();
  int totalPrice = 0;

  void calculateTotalPrice() {
    setState(() {
      totalPrice = int.tryParse(amountController.text) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a donation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedNGO,
              decoration: InputDecoration(
                labelText: 'Non-governmental organization',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedNGO = value;
                });
              },
              items: ['NGO 1', 'NGO 2', 'NGO 3']
                  .map((ngo) => DropdownMenuItem(value: ngo, child: Text(ngo)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              onChanged: (value) => calculateTotalPrice(),
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total price:',
                  style: TextStyle(fontSize: 16,),
                ),
                Text(
                  '$totalPrice\$',
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DonationSuccessDialog();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Donate',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
