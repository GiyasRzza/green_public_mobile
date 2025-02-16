import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

import '../../provider/PlacemarkProvider.dart';
import '../payment/paymentPage.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key,});

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  String? selectedNGO;
  final TextEditingController amountController = TextEditingController();
  int totalPrice = 0;
    String locationHeader="";
  @override
  void initState() {
    super.initState();
    fetchNGOs();
  }

  Future<http.Client> certificate() async {
      final p12Bytes = await rootBundle.load('assets/api-cibpay.p12');
      SecurityContext context = SecurityContext(withTrustedRoots: true);
      context.useCertificateChainBytes(p12Bytes.buffer.asUint8List(), password: "3/tYTB7OSPV4");
      context.usePrivateKeyBytes(p12Bytes.buffer.asUint8List(), password: "3/tYTB7OSPV4");
      final httpClient = HttpClient(context: context);
      return IOClient(httpClient);
    }

  String getBasicAuthHeader(String username, String password) {
    final credentials = '$username:$password';
    final encoded = base64Encode(utf8.encode(credentials));
    return 'Basic $encoded';
  }

  Future<void> sendPay() async {
    final client = await certificate();
    final url = Uri.parse('https://api-preprod.cibpay.co/orders/create');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': getBasicAuthHeader('cibpay', 'gxIO8aH6N3j13FREp2'),
    };

    final orderData = {
      "amount": amountController.text,
      "currency": "AZN",
      "extra_fields": {
        "invoice_id": "001",
        "oneclick": {
          "customer_id": "001",
          "prechecked": 1
        }
      },
      "merchant_order_id": "PKgn75jB",
      "options": {
        "auto_charge": true,
        "expiration_timeout": "4320m",
        "force3d": 0,
        "language": "az",
        "return_url": "https://cibpay.az",
        "terminal": "millikart_test",
        "country": "AZE",
        "recurring": 1
      },
      "custom_fields": {
        "region_code": 10,
        "home_phone_country_code": "123",
        "home_phone_subscriber": "123123123",
        "mobile_phone_country_code": "345",
        "mobile_phone_subscriber": "34535345345",
        "work_phone_country_code": "567",
        "work_phone_subscriber": "1565757567556"
      },
      "client": {
        "email": "pay@cibpay.az",
        "city": "Baku",
        "country": "AZE",
        "address": "Azadliq ave. 1",
        "zip": "1000"
      }
    };

    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(orderData),
      );
      print(response.statusCode);

      if (response.statusCode == 201 || response.statusCode == 200) {
        locationHeader = response.headers['location']!;
        if (locationHeader.isNotEmpty) {
          print('Location Header: $locationHeader');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentPage(
                paymentUrl: locationHeader,
              ),
            ),
          );
        } else {
          print('Location header not found.');
        }
      } else {
        print('Error Cibpay: ${response.body}');
      }
    } catch (e) {
      print('Error other Cibpay: $e');
    } finally {
      client.close();
    }
  }

  List<dynamic> ngos = [];

  Future<void> fetchNGOs() async {
    String eq="eq";
    String url = 'http://89.250.64.225/api/users?filters[type][$eq]=NGO&fields[0]=id&fields[1]=name';

    final response = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp',
      },);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        ngos = data;
      });
      ngos.forEach((element) {
          setState(() {
            if(element['name']== Provider.of<PlacemarkProvider>(context, listen: false).selectedNgo){
            }
          });
      },);
    } else {
      throw Exception('Failed to load NGOs');
    }
  }

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
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedNGO = value;
                });
              },
              items: ngos.map<DropdownMenuItem<String>>((ngo) {
                return DropdownMenuItem<String>(
                  value: ngo['id'].toString(),
                  child: Text(
                    ngo['name'],
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Count',
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    sendPay();

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
