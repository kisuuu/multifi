import 'package:flutter/material.dart';
import 'package:multifi/constants/constants.dart';
import 'package:multifi/screens/pages/home_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final amount;
  final packageName;
  final packageid;
  PaymentScreen({
    Key? key,
    this.amount,
    this.packageName,
    this.packageid,
  }) : super(key: key);
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late bool _isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var index;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: MainColor),
        ),
        backgroundColor: MainColor,
        elevation: 0,
      ),
      backgroundColor: bgColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: MainColor,
              ),
            )
          : Container(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl:
                    // ${pkgmapresponse?[index]['price_to_subscriber_cents']} ---- ${pkgmapresponse?[index]['name']}
                    'https://mpay.multifi.in/?cust_id=${dataresponse?['id']}&sub_id=${dataresponse?['subscriberid']}&amount=${widget.amount}&package=${widget.packageName}&name=${dataresponse?['name']}&mobile=${dataresponse?['phone1']}&email=${dataresponse?['email']}&city=${dataresponse?['city']}&state=${dataresponse?['state']}&zip=${dataresponse?['zip']}&country=${dataresponse?['country']}&address=${dataresponse?['address1']}&package_id=${widget.packageid}',
              ),
            ),
    );
  }
}
