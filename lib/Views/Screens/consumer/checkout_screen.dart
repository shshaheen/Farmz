import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:farmz/global_variables.dart';

class CheckoutScreen extends StatefulWidget {
  final double amount;

  const CheckoutScreen({super.key, required this.amount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _startPayment() async {
    final amountInPaise = (widget.amount * 100).toInt();
    final url = Uri.parse('$uri/api/payment/create-order');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amountInPaise}),
      );

      final json = jsonDecode(response.body);
      debugPrint("🔄 Server Response: $json");

      if (!mounted) return;

      if (!json['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Order creation failed')),
        );
        return;
      }

      final orderId = json['order']['id'];
      print(orderId);
      var options = {
        'key': 'rzp_test_fnnCA6wRnF7IAW',
        'amount': amountInPaise,
        'currency': 'INR',
        'name': 'Farmz',
        'description': 'Order Payment',
        'order_id': orderId,
        'prefill': {
          'contact': '9392235952',
          'email': 'kolimishaheen9885@gmail.com',
        },
      };

      debugPrint('🧾 Opening Razorpay with: $options');
      try {
        _razorpay.open(options);
      } catch (e, st) {
        print("Razorpay open error: $e\n$st");
      }
    } catch (e) {
      debugPrint("⚠️ Payment error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Something went wrong during payment.")),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("✅ Payment Success: ${response.paymentId}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ Payment successful: ${response.paymentId}")),
    );
    // TODO: Send confirmation to backend or update UI
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint(
        "❌ Payment Error: Code=${response.code}, Message=${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ Payment failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("💼 External Wallet Selected: ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("💼 Wallet selected: ${response.walletName}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Amount: ₹${widget.amount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPayment,
              child: Text("Pay Now"),
            )
          ],
        ),
      ),
    );
  }
}
