import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:ui';
import '../donation/widget/donation_success_dialog.dart';

class PaymentPage extends StatefulWidget {
  final String paymentUrl;
  const PaymentPage({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = true;
  bool showDialogFlag = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
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
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
            onLoadStart: (_, __) => setState(() => isLoading = true),
            onLoadStop: (_, url) {
              setState(() => isLoading = false);
              if (url?.toString().contains("cibpay.az") ?? false) {
                setState(() => showDialogFlag = true);
                Future.delayed(const Duration(milliseconds: 100), () {
                  showDialog(
                    context: context,
                    builder: (_) => const DonationSuccessDialog(),
                  ).then((_) => setState(() => showDialogFlag = false));
                });
              }
            },
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          if (showDialogFlag)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.black.withOpacity(0.8)),
              ),
            ),
        ],
      ),
    );
  }
}
