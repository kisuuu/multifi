// ignore_for_file: deprecated_member_use, non_constant_identifier_names, camel_case_types

import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:multifi/constants/api_string.dart';
import 'package:multifi/constants/constants.dart';
import 'package:multifi/constants/widgets.dart';
import 'package:multifi/model/dashboard_model.dart';
import 'package:multifi/model/package_list_model.dart';
import 'package:multifi/screens/payment_screen.dart';

Map? pkgdataresponse;
Map? pkgstringResponses;
List? pkgmapresponse;

Future<User> fetchUser() async {
  final response =
      await http.get(Uri.https('mpay.multifi.in', 'admin-cred.php'));
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load User');
  }
}

class User {
  String user;
  String pass;

  User({required this.user, required this.pass});

  Map<String, dynamic> toJson() => {'user': user, 'pass': pass};

  static User fromJson(Map<String, dynamic> json) => User(
        user: json['user'],
        pass: json['pass'],
      );
}

class ListPage extends StatefulWidget {
  static String? acces_token;

  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class PackageData {
  final String amount;
  final String packagename;

  PackageData(this.amount, this.packagename);
}

class _ListPageState extends State<ListPage> {
  late Future<User> futureUser;
  Future getAccessToken(var username, var password) async {
    final response = await http.post(
      Uri.parse(API_STRING.BASE_URL + API_STRING.ADMIN_LOGIN),
      headers: {
        "content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(
        <String, dynamic>{
          "email": username,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      ListPage.acces_token = json.decode(response.body)['auth_token'];
      getPackageList();
      // print(ListPage.acces_token);
    }
  }

  Future<pkgmodel?> getPackageList() async {
    final response = await http.get(
      Uri.parse(API_STRING.BASE_URL + API_STRING.lOCATION_PACKAGES),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authentication": "${ListPage.acces_token}",
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      // stringResponses = response.body;
      if (mounted) {
        setState(() {
          pkgstringResponses = json.decode(response.body);
          pkgmapresponse = pkgstringResponses!['data'];
        });
      }
    }
    return null;
  }

  // Future<User?> readUser() async {
  //   final docUser =
  //       FirebaseFirestore.instance.collection('Admin').doc('AdminLogin');
  //   final snapshot = await docUser.get();

  //   if (snapshot.exists) {
  //     return User.fromJson(snapshot.data()!);
  //   }
  //   return null;
  // }

// user kishan
// userkishan
  late bool _isLoading;
  @override
  void initState() {
    super.initState();
    getPackageList();
    // readUser();
    futureUser = fetchUser();
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
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
          backgroundColor: MainColor,
          elevation: 0,
        ),
      ),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                FutureBuilder<User>(
                    future: futureUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final users = snapshot.data;
                        var user = snapshot.data!.user;
                        var pass = snapshot.data!.pass;
                        // if (email != null) {
                        getAccessToken(user, pass);
                        print(snapshot.data!.user);
                        print(snapshot.data!.pass);
                        // }
                        // print("Email : $email , pass : $pass");
                        return users == null
                            ? const Center()
                            : (builUser(users));
                      } else {
                        return const Center();
                      }
                    }),
              ],
            ),
            Center(
              child: Column(
                children: const [
                  Text(
                    "Choose Your Plan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: <Widget>[
                _isLoading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              const NewCardSkelton(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        ),
                      )
                    : const packagelist(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builUser(User Admin) => const Center();
}

class packagelist extends StatelessWidget {
  const packagelist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.82,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        // physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Neumorphic(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Row(
                                children: <Widget>[
                                  _forPackageList(
                                    planHeaderText: 'PLAN',
                                    planMainText:
                                        '${pkgmapresponse![index]['price_to_subscriber_human']}',
                                    planAlignment: Alignment.topLeft,
                                  ),
                                  _forPackageList(
                                    planHeaderText: 'VALIDITY',
                                    planMainText:
                                        '${pkgmapresponse![index]['valid_for']} ${pkgmapresponse![index]['validity_unit']}',
                                    planAlignment: Alignment.center,
                                  ),
                                  _forPackageList(
                                    planHeaderText: 'DATA',
                                    planMainText:
                                        '${pkgmapresponse![index]['data']} ${pkgmapresponse![index]['data_unit']}',
                                    planAlignment: Alignment.topRight,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              enableDrag: false,
                                              isScrollControlled: true,
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(20.0),
                                                ),
                                              ),
                                              builder: (context) => Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: 140,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: MainColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                20.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                20.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          icon: const IconTheme(
                                                            data: IconThemeData(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .multiply_circle_fill,
                                                            ),
                                                          ),
                                                        ),
                                                        _viewPlanPrice(
                                                            viewPlanPrice:
                                                                '${pkgmapresponse![index]['price_to_subscriber_human']}'),
                                                        _forviewDataPack(
                                                            viewDataPack:
                                                                '${pkgmapresponse![index]['data']} ${pkgmapresponse![index]['data_unit']} Pack'),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 15),
                                                        child: Column(
                                                          children: [
                                                            _forPackageViewPlan(
                                                              viewPackageParameters:
                                                                  'Pack Validity',
                                                              viewPackageValue:
                                                                  '${pkgmapresponse![index]['valid_for']} ${pkgmapresponse![index]['validity_unit']}',
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            _forPackageViewPlan(
                                                              viewPackageParameters:
                                                                  'Total Data',
                                                              viewPackageValue:
                                                                  '${pkgmapresponse![index]['data']} ${pkgmapresponse![index]['data_unit']} Pack',
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            if (pkgmapresponse![
                                                                        index][
                                                                    'has_daily_limit'] ==
                                                                true)
                                                              (_forPackageViewPlan(
                                                                viewPackageParameters:
                                                                    'Daily Data Limite',
                                                                viewPackageValue:
                                                                    '${pkgmapresponse![index]['daily_data']} ${pkgmapresponse![index]['daily_data_unit']}',
                                                              ))
                                                            else
                                                              (_forPackageViewPlan(
                                                                viewPackageParameters:
                                                                    'Daily Data Limite',
                                                                viewPackageValue:
                                                                    'No Limite',
                                                              )),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            if (pkgmapresponse![
                                                                        index][
                                                                    'has_monthly_limit'] ==
                                                                true)
                                                              (_forPackageViewPlan(
                                                                viewPackageParameters:
                                                                    'Monthly Data Limite',
                                                                viewPackageValue:
                                                                    '${pkgmapresponse![index]['monthly_data']} ${pkgmapresponse![index]['monthly_data_unit']}',
                                                              ))
                                                            else
                                                              (_forPackageViewPlan(
                                                                viewPackageParameters:
                                                                    'Monthly Data Limite',
                                                                viewPackageValue:
                                                                    'No Limite',
                                                              )),
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            _forViewPlanDescription(
                                                              ViewPlanDescriptionParameters:
                                                                  'Description',
                                                              ViewPlanDescriptionValue:
                                                                  '${pkgmapresponse![index]['description']}',
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                PaymentScreen(
                                                                                  amount: pkgmapresponse![index]['price_to_subscriber_cents'] ~/ 100,
                                                                                  packageName: pkgmapresponse![index]['name'],
                                                                                  packageid: pkgmapresponse![index]['location_id'],
                                                                                )),
                                                                      );
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'BUY',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          MainColor,
                                                                      onPrimary:
                                                                          white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'View Plan',
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentScreen(
                                                        amount: pkgmapresponse![
                                                                    index][
                                                                'price_to_subscriber_cents'] ~/
                                                            100,
                                                        packageName:
                                                            pkgmapresponse![
                                                                index]['name'],
                                                        packageid:
                                                            pkgmapresponse![
                                                                    index]
                                                                ['location_id'],
                                                      )),
                                            );
                                          },
                                          child: const Text(
                                            'BUY',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: MainColor,
                                            onPrimary: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
          );
        },
        itemCount: pkgmapresponse == null ? 0 : pkgmapresponse!.length,
      ),
    );
  }

  Widget _forPackageList({
    required String planHeaderText,
    required String planMainText,
    required AlignmentGeometry planAlignment,
  }) {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          Align(
            alignment: planAlignment,
            child: Text(
              // 'PLAN',
              planHeaderText,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Align(
            alignment: planAlignment,
            child: Text(
              // '${pkgmapresponse![index]['price_to_subscriber_human']}',
              planMainText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _forPackageViewPlan({
    required String viewPackageParameters,
    required String viewPackageValue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewPackageParameters,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          viewPackageValue,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _forViewPlanDescription({
    required String ViewPlanDescriptionParameters,
    required String ViewPlanDescriptionValue,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          // 'Description',
          ViewPlanDescriptionParameters,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          // '${pkgmapresponse![index]['description']}',
          ViewPlanDescriptionValue,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _viewPlanPrice({
    required String viewPlanPrice,
  }) {
    return Center(
      child: Text(
        // '${pkgmapresponse![index]['price_to_subscriber_human']}',
        viewPlanPrice,
        style: const TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _forviewDataPack({
    required String viewDataPack,
  }) {
    return Center(
      child: Text(
        // '${pkgmapresponse![index]['price_to_subscriber_human']}',
        viewDataPack,
        style: const TextStyle(
          fontSize: 15,
          // fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}































// // ignore_for_file: deprecated_member_use, non_constant_identifier_names, camel_case_types

// import 'dart:convert';
// // import 'dart:html';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:http/http.dart' as http;
// import 'package:multifi/constants/api_string.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:multifi/constants/constants.dart';
// import 'package:multifi/constants/widgets.dart';
// import 'package:multifi/model/dashboard_model.dart';
// import 'package:multifi/model/package_list_model.dart';
// import 'package:multifi/screens/payment_screen.dart';

// Map? pkgdataresponse;
// Map? pkgstringResponses;
// List? pkgmapresponse;

// class ListPage extends StatefulWidget {
//   static String? acces_token;

//   const ListPage({Key? key}) : super(key: key);

//   @override
//   State<ListPage> createState() => _ListPageState();
// }

// class PackageData {
//   final String amount;
//   final String packagename;

//   PackageData(this.amount, this.packagename);
// }

// class _ListPageState extends State<ListPage> {
//   Future getAccessToken(var username, var password) async {
//     final response = await http.post(
//       Uri.parse(API_STRING.BASE_URL + API_STRING.ADMIN_LOGIN),
//       headers: {
//         "content-Type": "application/json",
//         "Accept": "application/json",
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           "email": username,
//           "password": password,
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       ListPage.acces_token = json.decode(response.body)['auth_token'];
//       getPackageList();
//       // print(ListPage.acces_token);
//     }
//   }

//   Future<pkgmodel?> getPackageList() async {
//     final response = await http.get(
//       Uri.parse(API_STRING.BASE_URL + API_STRING.lOCATION_PACKAGES),
//       headers: {
//         "content-type": "application/json",
//         "accept": "application/json",
//         "Authentication": "${ListPage.acces_token}",
//       },
//     );
//     // print(response.body);
//     if (response.statusCode == 200) {
//       // stringResponses = response.body;
//       if (mounted) {
//         setState(() {
//           pkgstringResponses = json.decode(response.body);
//           pkgmapresponse = pkgstringResponses!['data'];
//         });
//       }
//     }
//     return null;
//   }

//   Future<User?> readUser() async {
//     final docUser =
//         FirebaseFirestore.instance.collection('Admin').doc('AdminLogin');
//     final snapshot = await docUser.get();

//     if (snapshot.exists) {
//       return User.fromJson(snapshot.data()!);
//     }
//     return null;
//   }

// // user kishan
// // userkishan
//   late bool _isLoading;
//   @override
//   void initState() {
//     super.initState();
//     getPackageList();
//     readUser();
//     _isLoading = true;
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(0.0), // here the desired height
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(color: MainColor),
//           ),
//           backgroundColor: MainColor,
//           elevation: 0,
//         ),
//       ),
//       backgroundColor: bgColor,
//       body: Center(
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 18,
//                 ),
//                 FutureBuilder<User?>(
//                     future: readUser(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         final user = snapshot.data;
//                         var email = snapshot.data!.Email;
//                         var pass = snapshot.data!.Password;
//                         // if (email != null) {
//                         getAccessToken(email, pass);
//                         // }
//                         // print("Email : $email , pass : $pass");
//                         return user == null ? const Center() : (builUser(user));
//                       } else {
//                         return const Center();
//                       }
//                     }),
//               ],
//             ),
//             Center(
//               child: Column(
//                 children: const [
//                   Text(
//                     "Choose Your Plan",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Column(
//               children: <Widget>[
//                 _isLoading
//                     ? SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.75,
//                         width: MediaQuery.of(context).size.width,
//                         child: ListView.separated(
//                           itemCount: 5,
//                           itemBuilder: (context, index) =>
//                               const NewCardSkelton(),
//                           separatorBuilder: (context, index) => const SizedBox(
//                             height: 10,
//                           ),
//                         ),
//                       )
//                     : const packagelist(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget builUser(User Admin) => const Center();
// }

// class packagelist extends StatelessWidget {
//   const packagelist({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.82,
//       width: MediaQuery.of(context).size.width,
//       child: ListView.builder(
//         shrinkWrap: true,
//         // physics: ScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Neumorphic(
//                     child: Container(
//                       color: Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 8),
//                               child: Row(
//                                 children: <Widget>[
//                                   _forPackageList(
//                                     planHeaderText: 'PLAN',
//                                     planMainText:
//                                         '${pkgmapresponse![index]['price_to_subscriber_human']}',
//                                     planAlignment: Alignment.topLeft,
//                                   ),
//                                   _forPackageList(
//                                     planHeaderText: 'VALIDITY',
//                                     planMainText:
//                                         '${pkgmapresponse![index]['valid_for']} ${pkgmapresponse![index]['validity_unit']}',
//                                     planAlignment: Alignment.center,
//                                   ),
//                                   _forPackageList(
//                                     planHeaderText: 'DATA',
//                                     planMainText:
//                                         '${pkgmapresponse![index]['data']} ${pkgmapresponse![index]['data_unit']}',
//                                     planAlignment: Alignment.topRight,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 14),
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 30,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         TextButton(
//                                           style: TextButton.styleFrom(
//                                             textStyle:
//                                                 const TextStyle(fontSize: 12),
//                                           ),
//                                           onPressed: () {
//                                             showModalBottomSheet(
//                                               enableDrag: false,
//                                               isScrollControlled: true,
//                                               context: context,
//                                               shape:
//                                                   const RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.vertical(
//                                                   top: Radius.circular(20.0),
//                                                 ),
//                                               ),
//                                               builder: (context) => Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Container(
//                                                     height: 140,
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                             .size
//                                                             .width,
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       color: MainColor,
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 20.0),
//                                                         topLeft:
//                                                             Radius.circular(
//                                                                 20.0),
//                                                       ),
//                                                     ),
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .end,
//                                                       children: [
//                                                         IconButton(
//                                                           onPressed: () =>
//                                                               Navigator.pop(
//                                                                   context),
//                                                           icon: const IconTheme(
//                                                             data: IconThemeData(
//                                                               color:
//                                                                   Colors.grey,
//                                                             ),
//                                                             child: Icon(
//                                                               CupertinoIcons
//                                                                   .multiply_circle_fill,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         _viewPlanPrice(
//                                                             viewPlanPrice:
//                                                                 '${pkgmapresponse![index]['price_to_subscriber_human']}'),
//                                                         _forviewDataPack(
//                                                             viewDataPack:
//                                                                 '${pkgmapresponse![index]['data']} ${pkgmapresponse![index]['data_unit']} Pack'),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Column(
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .symmetric(
//                                                                 horizontal: 15,
//                                                                 vertical: 15),
//                                                         child: Column(
//                                                           children: [
//                                                             _forPackageViewPlan(
//                                                               viewPackageParameters:
//                                                                   'Pack Validity',
//                                                               viewPackageValue:
//                                                                   '${pkgmapresponse![index]['valid_for']} ${pkgmapresponse![index]['validity_unit']}',
//                                                             ),
//                                                             const SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             _forPackageViewPlan(
//                                                               viewPackageParameters:
//                                                                   'Total Data',
//                                                               viewPackageValue:
//                                                                   '${pkgmapresponse![index]['data']} ${pkgmapresponse![index]['data_unit']} Pack',
//                                                             ),
//                                                             const SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             if (pkgmapresponse![
//                                                                         index][
//                                                                     'has_daily_limit'] ==
//                                                                 true)
//                                                               (_forPackageViewPlan(
//                                                                 viewPackageParameters:
//                                                                     'Daily Data Limite',
//                                                                 viewPackageValue:
//                                                                     '${pkgmapresponse![index]['daily_data']} ${pkgmapresponse![index]['daily_data_unit']}',
//                                                               ))
//                                                             else
//                                                               (_forPackageViewPlan(
//                                                                 viewPackageParameters:
//                                                                     'Daily Data Limite',
//                                                                 viewPackageValue:
//                                                                     'No Limite',
//                                                               )),
//                                                             const SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             if (pkgmapresponse![
//                                                                         index][
//                                                                     'has_monthly_limit'] ==
//                                                                 true)
//                                                               (_forPackageViewPlan(
//                                                                 viewPackageParameters:
//                                                                     'Monthly Data Limite',
//                                                                 viewPackageValue:
//                                                                     '${pkgmapresponse![index]['monthly_data']} ${pkgmapresponse![index]['monthly_data_unit']}',
//                                                               ))
//                                                             else
//                                                               (_forPackageViewPlan(
//                                                                 viewPackageParameters:
//                                                                     'Monthly Data Limite',
//                                                                 viewPackageValue:
//                                                                     'No Limite',
//                                                               )),
//                                                             const SizedBox(
//                                                               height: 30,
//                                                             ),
//                                                             _forViewPlanDescription(
//                                                               ViewPlanDescriptionParameters:
//                                                                   'Description',
//                                                               ViewPlanDescriptionValue:
//                                                                   '${pkgmapresponse![index]['description']}',
//                                                             ),
//                                                             const SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 SizedBox(
//                                                                   width: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .width *
//                                                                       0.9,
//                                                                   child:
//                                                                       ElevatedButton(
//                                                                     onPressed:
//                                                                         () async {
//                                                                       Navigator
//                                                                           .push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                             builder: (context) =>
//                                                                                 PaymentScreen(
//                                                                                   amount: pkgmapresponse![index]['price_to_subscriber_cents'] ~/ 100,
//                                                                                   packageName: pkgmapresponse![index]['name'],
//                                                                                   packageid: pkgmapresponse![index]['location_id'],
//                                                                                 )),
//                                                                       );
//                                                                     },
//                                                                     child:
//                                                                         const Text(
//                                                                       'BUY',
//                                                                       style: TextStyle(
//                                                                           fontSize:
//                                                                               12),
//                                                                     ),
//                                                                     style: ElevatedButton
//                                                                         .styleFrom(
//                                                                       primary:
//                                                                           MainColor,
//                                                                       onPrimary:
//                                                                           white,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                           child: const Text(
//                                             'View Plan',
//                                           ),
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () async {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       PaymentScreen(
//                                                         amount: pkgmapresponse![
//                                                                     index][
//                                                                 'price_to_subscriber_cents'] ~/
//                                                             100,
//                                                         packageName:
//                                                             pkgmapresponse![
//                                                                 index]['name'],
//                                                         packageid:
//                                                             pkgmapresponse![
//                                                                     index]
//                                                                 ['location_id'],
//                                                       )),
//                                             );
//                                           },
//                                           child: const Text(
//                                             'BUY',
//                                             style: TextStyle(fontSize: 12),
//                                           ),
//                                           style: ElevatedButton.styleFrom(
//                                             primary: MainColor,
//                                             onPrimary: white,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         itemCount: pkgmapresponse == null ? 0 : pkgmapresponse!.length,
//       ),
//     );
//   }

//   Widget _forPackageList({
//     required String planHeaderText,
//     required String planMainText,
//     required AlignmentGeometry planAlignment,
//   }) {
//     return Expanded(
//       flex: 1,
//       child: Column(
//         children: <Widget>[
//           Align(
//             alignment: planAlignment,
//             child: Text(
//               // 'PLAN',
//               planHeaderText,
//               style: const TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey),
//             ),
//           ),
//           Align(
//             alignment: planAlignment,
//             child: Text(
//               // '${pkgmapresponse![index]['price_to_subscriber_human']}',
//               planMainText,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _forPackageViewPlan({
//     required String viewPackageParameters,
//     required String viewPackageValue,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           viewPackageParameters,
//           style: const TextStyle(
//             fontSize: 15,
//           ),
//         ),
//         Text(
//           viewPackageValue,
//           style: const TextStyle(
//             fontSize: 15,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _forViewPlanDescription({
//     required String ViewPlanDescriptionParameters,
//     required String ViewPlanDescriptionValue,
//   }) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           // 'Description',
//           ViewPlanDescriptionParameters,
//           style: const TextStyle(
//             fontSize: 15,
//           ),
//         ),
//         Text(
//           // '${pkgmapresponse![index]['description']}',
//           ViewPlanDescriptionValue,
//           style: const TextStyle(
//             fontSize: 15,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _viewPlanPrice({
//     required String viewPlanPrice,
//   }) {
//     return Center(
//       child: Text(
//         // '${pkgmapresponse![index]['price_to_subscriber_human']}',
//         viewPlanPrice,
//         style: const TextStyle(
//             fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//     );
//   }

//   Widget _forviewDataPack({
//     required String viewDataPack,
//   }) {
//     return Center(
//       child: Text(
//         // '${pkgmapresponse![index]['price_to_subscriber_human']}',
//         viewDataPack,
//         style: const TextStyle(
//           fontSize: 15,
//           // fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
