// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

//colors used in this app
const Color white = Colors.white;
const Color black = Colors.black;
const Color yellow = Color(0xFFFFD54F);

//default app padding
const double appPadding = 20.0;

const Color MainColor = Color.fromARGB(255, 3, 61, 64);
const Color bgColor = Color.fromARGB(255, 245, 245, 253);
// Color containerbgColor = Color.fromARGB(255, 250, 222, 222);

// ignore: non_constant_identifier_names
var WhiteContainer = Container(
  decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50),
      topRight: Radius.circular(50),
    ),
  ),
);
