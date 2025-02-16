import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui';

import '../donation/widget/donation_success_dialog.dart';

class PaymentPage extends StatefulWidget {
  final String paymentUrl;

  const PaymentPage({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController controller;
  bool isLoading = true;
  bool showDialogFlag = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (WebResourceError error) {
          print('WebView Error: ${error.description}');
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.contains("cibpay.az")) {
            setState(() {
              showDialogFlag = true;
            });
            Future.delayed(const Duration(milliseconds: 100), () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DonationSuccessDialog();
                },
              ).then((_) {
                setState(() {
                  showDialogFlag = false;
                });
              });
            });
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (showDialogFlag)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
