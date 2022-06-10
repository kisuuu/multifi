// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:multifi/constants/constants.dart';
import 'package:multifi/screens/intro_screens/screen_two.dart';
import 'package:multifi/screens/login_screen.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({Key? key}) : super(key: key);

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
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
          backgroundColor: MainColor,
          elevation: 0,
        ),
      ),
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Column(
            children: [
              buildSkipButton(),
              buildImage(),
              buildBottomContainer(context),
            ],
          )
        ],
      ),
    );
  }

  Expanded buildBottomContainer(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        // color: Colors.white,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          color: Colors.white,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Welcome to Multifi",
                    textAlign: TextAlign.center,
                    // style: TextStyle(
                    //   fontSize: 26,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: const [
                Text(
                  "Get connected to the Internet\nat blazing speeds",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: appPadding / 4),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      border: Border.all(color: black, width: 2),
                      shape: BoxShape.circle,
                      color: white),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: appPadding / 4),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      border: Border.all(color: black, width: 2),
                      shape: BoxShape.circle,
                      color: MainColor),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: appPadding / 4),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      border: Border.all(color: black, width: 2),
                      shape: BoxShape.circle,
                      color: MainColor),
                ),
              ],
            ),
            Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OnboardingScreenTwo(),
                      ),
                    );
                  },
                  backgroundColor: white,
                  child: const Icon(
                    Icons.navigate_next_rounded,
                    color: black,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: const Image(
        fit: BoxFit.fitHeight,
        image: AssetImage("assets/images/intro_1.png"),
      ),
    );
  }

  Column buildSkipButton() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topRight,
          child: TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size.fromWidth(35),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            child: const Align(
              // alignment: Alignment.topRight,
              child: Text(
                "Skip",
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                // textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
