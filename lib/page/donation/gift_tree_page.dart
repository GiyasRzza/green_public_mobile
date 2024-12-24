import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:green_public_mobile/page/donation/payment_received_page.dart';
import '../../provider/PlacemarkProvider.dart';
import '../../provider/TreeProvider.dart';

class GiftTreePage extends StatefulWidget {
  const GiftTreePage({super.key});

  @override
  State<GiftTreePage> createState() => _GiftTreePageState();
}

class _GiftTreePageState extends State<GiftTreePage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedTree;
  int? numberOfTrees;
  String? selectedLocation;
  String? recipientName;
  String? recipientSurname;
  String? recipientEmail;
  String? donorName;
  String? reason;
  String? message;
  bool specialMessage = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final requestBody = {
        "data": {
          "tree": selectedTree,
          "placemark": selectedLocation,
          "recipientName": recipientName,
          "recipientSurname": recipientSurname,
          "recipientEmail": recipientEmail,
          "donorName": donorName,
          "reason": reason,
          "message": message,
          "specialMessage": specialMessage,
        }
      };

      try {
        final response = await http.post(
          Uri.parse('http://37.60.230.124/api/gifts'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          _showSuccessPopup(context);
        } else {
          _showErrorPopup(context, 'Error: ${response.statusCode}');
          print(response.body);
        }
      } catch (error) {
        _showErrorPopup(context, 'Failed to send request: $error');}
    }
  }

  @override
  Widget build(BuildContext context) {
    final placemarkProvider = Provider.of<PlacemarkProvider>(context);
    final treeProvider = Provider.of<TreeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Give a tree as gift'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FutureBuilder<List<String>>(
                  future: treeProvider.treeFutureList
                      .then((trees) => trees.map((tree) => tree.name).toList()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading trees.');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No trees available.');
                    } else {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select a tree',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        items: snapshot.data!.map((String treeName) {
                          return DropdownMenuItem<String>(
                            value: treeName,
                            child: Text(treeName),
                          );
                        }).toList(),
                        onChanged:  (value) {
                          selectedTree = value;
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of trees',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onSaved: (value) =>
                  numberOfTrees = int.tryParse(value ?? '0') ?? 0,
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<String>>(
                  future: placemarkProvider.futurePlacemark
                      .then((placemarks) => placemarks.map((placemark) => placemark.name).toList()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading locations.');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No locations available.');
                    } else {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        items: snapshot.data!.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(
                              location.length > 30
                                  ? '${location.substring(0, 30)}...'
                                  : location,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                            selectedLocation =value;
                        },
                      );

                    }
                  },
                ),
                const SizedBox(height: 10),
                _buildTextFormField('The recipient\'s name', (value) => recipientName = value),
                const SizedBox(height: 10),
                _buildTextFormField('The recipient\'s surname', (value) => recipientSurname = value),
                const SizedBox(height: 10),
                _buildTextFormField('The recipient\'s email address', (value) => recipientEmail = value,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                _buildTextFormField('Giver\'s full name', (value) => donorName = value),
                const SizedBox(height: 10),
                _buildTextFormField('The reason of the gift', (value) => reason = value),
                const SizedBox(height: 10),
                _buildTextFormField('Special message', (value) => message = value),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: const Text(
                      'Write a special message on the gift certificate?'),
                  value: specialMessage,
                  onChanged: (bool value) {
                    setState(() {
                      specialMessage = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Donate'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText, Function(String?) onSave,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onSaved: onSave,
    );
  }

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Donation successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentReceivedPage(),
                  ),
                );
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorPopup(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}