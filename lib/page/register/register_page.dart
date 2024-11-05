import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/register/sign_up_company_screen.dart';
import 'package:green_public_mobile/page/register/sign_up_ngo_page.dart';
import 'package:green_public_mobile/page/register/sign_up_person_page.dart';
import 'package:green_public_mobile/provider/StoreProvider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<StoreProvider>(
          builder: (BuildContext context, StoreProvider value, Widget? child) {
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lovely to meet you',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Before we begin, we need some small details',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                   value.changeCount(1);
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.person, color: Colors.green),
                    title: const Text("Natural person", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text("Lorem ipsum dolor sit amet"),
                    trailing: value.selectedCount==1?const Icon(Icons.radio_button_checked, color: Colors.grey) :const Icon(Icons.radio_button_off, color: Colors.grey),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    value.changeCount(2);
                  },
                  child:  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.business, color: Colors.green),
                    title: const Text("Company", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text("Lorem ipsum dolor sit amet"),
                    trailing: value.selectedCount==2?const Icon(Icons.radio_button_checked, color: Colors.grey) :const Icon(Icons.radio_button_off, color: Colors.grey),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    value.changeCount(3);
                  },
                  child:  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.people, color: Colors.green),
                    title: const Text("Governmental company", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text("Lorem ipsum dolor sit amet"),
                    trailing:   value.selectedCount==3?const Icon(Icons.radio_button_checked, color: Colors.grey) :const Icon(Icons.radio_button_off, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if(value.selectedCount==1){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPersonScreen(),));
                    }
                    if(value.selectedCount==2){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpCompanyScreen(),));
                    }
                    if(value.selectedCount==3){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpNGOScreen(),));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Text('Next', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Explore without registration',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

