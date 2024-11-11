import 'package:flutter/material.dart';

class PaymentReceivedPage extends StatelessWidget {
  const PaymentReceivedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF3A5A40),
            height: 300,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.white, size: 60),
                  SizedBox(height: 8),
                  Text(
                    'Payment received',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
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
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400, width: 1.5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // NGO
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                                  ),
                                ),
                                child: const ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('NGO'),
                                      Text('Lorem ipsum',textAlign: TextAlign.right,),
                                    ],
                                  ),
                                ),
                              ),
                              // Date
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                                  ),
                                ),
                                child: const ListTile(
                                  title:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date'),
                                      Text('03/04/2024',textAlign: TextAlign.right,),
                                    ],
                                  ),
                                ),
                              ),
                              // Time
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                                  ),
                                ),
                                child: const ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Time'),
                                      Text('12:43',textAlign: TextAlign.right,),
                                    ],
                                  ),
                                ),
                              ),
                              // Amount
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                                  ),
                                ),
                                child: const ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Amount'),
                                      Text('1000\$',textAlign: TextAlign.right,),
                                    ],
                                  ),
                                ),
                              ),
                              // Total Cost
                              Container(
                                child: const ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total cost'),
                                      Text('1000\$',textAlign: TextAlign.right,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
}
