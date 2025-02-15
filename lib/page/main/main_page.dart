import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/main/widget/main_app_bar.dart';
import 'package:green_public_mobile/page/main/widget/main_body.dart';
import 'package:green_public_mobile/page/main/widget/main_bottom_navigation_bar.dart';
import 'package:green_public_mobile/page/payment/paymentPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(350),
      child: MainAppBar()),
      body: const MainBody(),
      bottomNavigationBar: MainBottomNavigationBar(currentPageIndex: 0,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PaymentPage(
                paymentUrl: 'https://checkout-preprod.cibpay.co/pay/91532085758869474',
              ),
            ),
          );
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
