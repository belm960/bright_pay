import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BrightPay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.flash_on,
              size: 50,
              color: Colors.orange,
            ),
            SizedBox(height: 20),
            Text(
              'Illuminate Your World',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.lightbulb,
              size: 100,
              color: Colors.yellow,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Background color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // Handle button press
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentForm(),
                  ),
                );
                        },
              child: Text(
                'Ha! :) Recharge',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Easily manage and pay your electric bills with BrightPay.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() => setState(() {}));
    _amountFocusNode.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _amountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _amountFocusNode.dispose();
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool isValidEthiopianPhoneNumber(String phoneNumber) {
    final RegExp regex = RegExp(r'^\+251[79]\d{8}$');
    return regex.hasMatch(phoneNumber);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.red,
        title: const Text('BrightPay Recharge',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(45.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 80,),
              Text(
                'It is Easy!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Recharge your account quickly and easily with BrightPay.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      focusNode: _phoneFocusNode,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Receiving Number!', 
                        hintText: '+251945242672',
                        suffixIcon: Icon(Icons.phone),
                        suffixIconColor: Colors.red,
                        focusColor: Colors.red,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }else if (!isValidEthiopianPhoneNumber(value)) {
                        return 'Please enter a valid Ethiopian phone number';
                      }
                        return null;
                      },
                    ),
                    TextFormField(
                      focusNode: _amountFocusNode,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount (ETB)',
                        suffixIcon: Icon(Icons.money),
                        suffixIconColor: Colors.red,
                        focusColor: Colors.red,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color
                      onPrimary: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                      onPressed: _submit,
                      child: const Text('Recharge',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ],
                ),
              ),]
      ),
    ));
  }

  Future<void> _submit() async{
    if (_formKey.currentState!.validate()) {
      String phone = _phoneController.text;
      String amount = _amountController.text;


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(phone: phone, amount: amount),
        ),
      );
  }
}
}

class PaymentPage extends StatefulWidget {
  final String phone;
  final String amount;

  const PaymentPage({super.key, required this.phone, required this.amount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String status = '';
  String checkoutUrl = '';
  String amount = '';
  String txRef = '';
  @override
  void initState() {
    super.initState();
    _startPayment();
  }

  void _startPayment() async {
    String chapaApiKey = 'CHASECK_TEST-YPSr0j8iNMFJg2a1S';
    String chapaUrl = 'https://api.chapa.co/v1/transaction/mobile-initialize';
    String txref = "tx_ref_${DateTime.now().millisecondsSinceEpoch}";
    var response = await http.post(
      Uri.parse(chapaUrl),
      headers: {
        'Authorization': 'Bearer $chapaApiKey',
      },
      body: {
        "amount": "${widget.amount}",
        "currency": "ETB",
        "email": 'usersam@gmail.com',
        "first_name": "John",
        "last_name": "Doe",
        "tx_ref": txref,
        "callback_url": "https://example.com/callback",
        "return_url": "https://example.com/return",
        "customization[title]": "Payment for XYZ",
        "customization[description]": "Payment for XYZ product",
        "namedRouteFallBack": "/second"
      });

    if (response.statusCode == 200) {
      status = 'Success';
      print('Transaction Successfull');
      var data = jsonDecode(response.body);
      checkoutUrl = data['data']['checkout_url'];
      amount = widget.amount;
      txRef = txref;

      // Save the transaction reference number
      // You can save it to a database or local storage for later verification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPayment(url: checkoutUrl, txref: txRef,amount: amount, phone: widget.phone),
        ),
      );
    } else {
      // Handle error
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayError(error: 'Error: ${response.body}'),
        ),
      );

      print('hi sami');
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.red,
        title: Text('Processing Payment',
        style: TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.red,
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}

class WebViewPayment extends StatelessWidget {
  final String url;
  final String txref;
  final String amount;
  final String phone;
  String status = '';

  WebViewPayment({required this.url,required this.txref, required this.amount, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.red,
        title: Text('Complete Payment',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: WebViewWidget(
            controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://example.com/return')) {
                    verifyPayment(context);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(this.url))
      ),
    );
  }

// Function to verify payment
Future<void> verifyPayment(context) async {
  String chapaUrl = 'https://api.chapa.co/v1/transaction/verify/$txref';
  String chapaApiKey = 'CHASECK_TEST-YPSr0j8iNMFJg2a1Ss'; // Replace with your Chapa API key

  var response = await http.get(
    Uri.parse(chapaUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $chapaApiKey',
    },
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccess(message: 'Payment Successful', transactionReference: txref, amountPaid: amount, phone: phone,),
        ),
      );
    }
      // Handle payment verification failure
  } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayError(error: 'Error: ${response.body}'),
        ),
      );
  }
}
}

class DisplayError extends StatelessWidget {
  final String error;

  DisplayError({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.red,
        title: Text('Error Here!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(child: Center(child: Text(error, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),))
    );
  }
}


class PaymentSuccess extends StatefulWidget {
  final String message;
  final String transactionReference;
  final String amountPaid;
  final String phone;

  const PaymentSuccess({super.key, required this.message, required this.transactionReference, required this.amountPaid, required this.phone});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  String status = '';
  @override
  void initState() {
    super.initState();
    _sendMessage();
  }

  void _sendMessage() async {
    String accountSid = 'acount sid';
    String authToken = 'auth token';
    String twilioNumber = '+1423589';
    final url = Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'From': twilioNumber,
        'To': widget.phone,
        'Body': widget.amountPaid,
      },
    );

    if (response.statusCode == 201) {
      print('SMS sent successfully.');
    } else {
      print('Failed to send SMS: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.green,
        title: Text('Payment Status',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Transaction Reference:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                widget.transactionReference,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Amount Paid:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                '${widget.amountPaid} ETB',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                      style: ButtonStyle(
                      backgroundColor:MaterialStatePropertyAll(Colors.green), // Background color
                      foregroundColor: MaterialStatePropertyAll(Colors.white), // Text color
                      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),)
                    ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text('Return to Home',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}