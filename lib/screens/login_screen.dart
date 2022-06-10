// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:ui';
import 'dart:io' show exit;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:multifi/constants/api_string.dart';
import 'package:multifi/constants/constants.dart';
import 'package:multifi/constants/widgets.dart';
import 'package:multifi/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String? acces_token;
  static String? error;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future getAccessToken(var username, var password) async {
    final response = await http.post(
      Uri.parse(API_STRING.BASE_URL + API_STRING.SUBSCRIBER_LOGIN),
      headers: {
        "content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(
        <String, dynamic>{
          "domain": "prl.xceednetdemo.com",
          "username": username,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      LoginScreen.acces_token = json.decode(response.body)['auth_token'];
      subscriberLogin();
    }
    if (response.statusCode == 404) {
      LoginScreen.error = json.decode(response.body)['error'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.only(bottom: 100.0),
        content: Text("${LoginScreen.error}"),
        duration: const Duration(milliseconds: 3000),
        backgroundColor: Colors.red,
      ));
    }
    if (response.statusCode == 401) {
      LoginScreen.error = json.decode(response.body)['error'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Error: ${LoginScreen.error}"),
        duration: const Duration(milliseconds: 3000),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future subscriberLogin() async {
    final response = await http.get(
      Uri.parse(API_STRING.BASE_URL + API_STRING.SUBSCRIBER_DASHBOARD),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authentication": "${LoginScreen.acces_token}",
      },
    );
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  bool hidePassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () => _onWillPop(context),
      onWillPop: () => exit(0),
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
        body: Stack(
          children: [
            Column(
              children: [
                buildLogo(),
                buildImage(),
                buildBottomContainer(context),
              ],
            ),
          ],
        ),
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

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Center(
                          child: Text(
                            'Login',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Hello, Welcome to Multifi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 30.0, left: 30.0),
                          child: TextFormField(
                            controller: usernameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "username can't be empty";
                              }
                              return null;
                            },
                            decoration: buildInputDecoration(
                              "Username",
                              Icons.person,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 30.0, left: 30.0),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: hidePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password can't be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              prefixIcon:
                                  const Icon(Icons.lock, color: MainColor),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: MainColor,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: MainColor,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  // hidePassword = !hidePassword;
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: MainColor,
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 30.0, left: 30.0),
                          child: buildButton(),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: const Image(
        fit: BoxFit.fitHeight,
        image: AssetImage("assets/images/login.png"),
      ),
    );
  }

  Column buildLogo() {
    return Column(
      children: const [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Image(
              image: AssetImage('assets/images/multifi_logo.png'),
              height: 50,
            ),
          ),
        ),
      ],
    );
  }

  // Widget buildButton() => ButtonWidget(
  //     text: 'LOGIN',
  //     onClicked: () {
  //       if (formKey.currentState!.validate()) {
  //         getAccessToken(usernameController.text, passwordController.text);
  //       }
  //     });
  Widget buildButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 20,
          ),
          primary: MainColor,
          minimumSize: Size.fromHeight(50),
          shape: StadiumBorder(),
        ),
        child: isLoading
            ? CircularProgressIndicator(
                color: white,
              )
            : Text(
                'Login',
              ),
        onPressed: () async {
          if (isLoading) return;

          setState(() => isLoading = true);
          await Future.delayed(Duration(seconds: 3));

          setState(() => isLoading = false);
          if (formKey.currentState!.validate()) {
            getAccessToken(usernameController.text, passwordController.text);
          }
        },
      );
}
