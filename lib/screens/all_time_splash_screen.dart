import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multifi/constants/constants.dart';
import 'package:multifi/screens/login_screen.dart';

class AllTimeSplashScreen extends StatefulWidget {
  const AllTimeSplashScreen({Key? key}) : super(key: key);

  @override
  State<AllTimeSplashScreen> createState() => _AllTimeSplashScreenState();
}

class _AllTimeSplashScreenState extends State<AllTimeSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0), // here the desired height
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: MainColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      backgroundColor: bgColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 7,
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/multifi_logo.png',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Powered by Mobisoftseo Technologies',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
