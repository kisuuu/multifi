// ignore_for_file: camel_case_types
import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:multifi/constants/api_string.dart';
import 'package:multifi/constants/constants.dart';
import 'package:multifi/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? stringResponse;
Map? mapresponse;
Map? locationmapresponse;
Map? dataresponse;
Map? locationresponse;

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final VoidCallback onPressed;
  Future subscriberDashboard() async {
    final response = await http.get(
      Uri.parse(API_STRING.BASE_URL + API_STRING.SUBSCRIBER_DASHBOARD),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authentication": "${LoginScreen.acces_token}",
      },
    );
    final location = await http.get(
      Uri.parse(API_STRING.BASE_URL + API_STRING.SUBSCRIBER_LOCATION),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authentication": "${LoginScreen.acces_token}",
      },
    );
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          // stringResponse = response.body;
          mapresponse = json.decode(response.body);
          dataresponse = mapresponse;
          mapresponse = json.decode(location.body);
          locationresponse = locationmapresponse;
        });
      }
    }
  }

  @override
  void initState() {
    subscriberDashboard();
    super.initState();
  }

  List<int> data = [];

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => exit(0),
          child: const Text('Yes'),
        ),
      ],
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(color: MainColor),
            ),
            backgroundColor: MainColor,
            elevation: 0,
          ),
        ),
        backgroundColor: bgColor,
        body: RefreshIndicator(
          onRefresh: subscriberDashboard,
          color: MainColor,
          child: const dashboardData(),
        ),
      ),
    );
  }
}

class dashboardData extends StatefulWidget {
  const dashboardData({
    Key? key,
  }) : super(key: key);

  @override
  State<dashboardData> createState() => _dashboardDataState();
}

class _dashboardDataState extends State<dashboardData> {
  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var novalue = 'dd MMM, yyyy hh:mm a' as DateTime;
    // late DateTime? rtimes = DateFormat('dd MMM, yyyy hh:mm a')
    //     .format(dataresponse?['renewed_at'] ?? novalue) as DateTime?;
    DateTime rtime = dataresponse?['renewed_at'] != null
        ? DateTime.parse(dataresponse?['renewed_at'])
        : DateTime.now();
    final rmyTime = DateFormat('dd MMM, yyyy hh:mm a').format(rtime);
    DateTime etime = dataresponse?['expires_at'] != null
        ? DateTime.parse(dataresponse?['expires_at'])
        : DateTime.now();
    final emyTime = DateFormat('dd MMM, yyyy hh:mm a').format(etime);
    // print(Text(
    //   rtimes == null ? 'No Date Chosen!' : DateFormat.yMd().format(rtimes),
    // ));

    // final etime = DateTime.tryParse(dataresponse?['expires_at'] ?? '');
    // final emyTime = DateFormat('dd MMM, yyyy hh:mm a').format(etime!);

    // Moment rawDate = Moment.parse(dataresponse?['renewed_at'] ?? '');
    // print(rawDate.format("dd-MM-yyyy HH:mm"));
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: const [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/multifi_logo.png',
                                ),
                                height: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      // fit: StackFit.expand,
                      children: <Widget>[
                        Neumorphic(
                          child: Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(19.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hello, ${dataresponse?['name']}\n',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          height: 2,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text:
                                          'Welcome to multifi\nspeed up your life',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                            left: 120,
                            top: 40,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/homeScreen.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Neumorphic(
                    child: Container(
                      color: MainColor,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Your Plan\n",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                ),
                              ),
                              if (dataresponse?['location_package_name'] ==
                                  null)
                                (const TextSpan(
                                  text: '-',
                                  // location_package_name
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                              else
                                (TextSpan(
                                  text:
                                      '${dataresponse?['location_package_name']}',
                                  // location_package_name
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              // TextSpan(
                              //   text:
                              //       '${dataresponse?['location_package_name']}',
                              //   // location_package_name
                              //   style: const TextStyle(
                              //     fontSize: 18,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Neumorphic(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            if (dataresponse?['renewed_at'] == null)
                              (_forPackageDateHeader(
                                  viewPackageDateHeader: 'Plan Renewed at',
                                  viewPackageDate: '-'))
                            else
                              (_forPackageDateHeader(
                                  viewPackageDateHeader: 'Plan Renewed at',
                                  viewPackageDate: rmyTime)),

                            // "Plan Renewed at",

                            const SizedBox(
                              height: 10,
                            ),
                            // '${dataresponse!['renewed_at']}',
                            // rmyTime,
                            if (dataresponse?['expires_at'] == null)
                              (_forPackageDateHeader(
                                  viewPackageDateHeader: 'Plan Expiry on',
                                  viewPackageDate: '-'))
                            else
                              (_forPackageDateHeader(
                                viewPackageDateHeader: 'Plan Expiry on',
                                viewPackageDate: emyTime,
                              ))
                          ],
                          // emyTime,
                          // "${dd MMM, yyyy hh:mm a}",
                          // ${dataresponse?['expires_at']}
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Neumorphic(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Data Used Today\n",
                                              // data_used_total
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${dataresponse?['data_used_today_human']}',
                                              // '${dataresponse?['data_used_today']}',
                                              // '20 MB',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              // height: 20,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                              color: Colors.grey,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Data Used In This Month\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${dataresponse?['data_used_monthly_human']}',
                                          // '${dataresponse?['data_used_monthly']}',
                                          // '555 MB',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Data Used Total\n",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                // '${dataresponse?['data_used_total']}',
                                                '${dataresponse?['data_used_today_human']}',
                                            // '575 MB',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _forPackageDateHeader({
    required String viewPackageDateHeader,
    required String viewPackageDate,
    // required String viewPackageDate,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                // "Plan Expiry on",
                viewPackageDateHeader,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                viewPackageDate,
                // '${dataresponse!['renewed_at']}',
                // rmyTime,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
