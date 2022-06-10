// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:multifi/constants/constants.dart';
import 'package:multifi/screens/pages/home_page.dart';
import 'package:multifi/screens/pages/package_list_page.dart';
import 'package:multifi/screens/pages/support_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pages = [
    const HomePage(),
    const ListPage(),
    const SupportPage(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
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
      body: Center(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Plans"),
          BottomNavigationBarItem(
              icon: Icon(Icons.headphones), label: "support"),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: MainColor,
        onTap: onTap,
      ),
    );
  }
}
