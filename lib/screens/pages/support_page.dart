// ignore_for_file: camel_case_types
import 'package:package_info/package_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:multifi/constants/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
    appName: '',
    buildNumber: '',
    packageName: '',
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
    // init();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.android_sharp, size: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
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
    );
  }

  // https://www.youtube.com/watch?v=qitGrisWCPw
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Column(
                children: [
                  buildLogo(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Multicraft Digital Technologies Pvt. Ltd',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12.0,
                    ),
                  ),

                  // Text('$version');
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              Column(
                children: [
                  const _forAddress(),
                  const Divider(),
                  const _forEmailSupport(),
                  const Divider(),
                  const _forContact(),
                  const Divider(),
                  _infoTile(
                    'App version',
                    _packageInfo.version,
                  ),
                ],
              ),
              // Spacer(),
            ],
          ),
        ),
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
}

class _forAddress extends StatelessWidget {
  const _forAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        CupertinoIcons.home,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "202, Ecstasy Business Park, JSD,\n",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Near City Of Joy, Mulund West,\n",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Mumbai, Maharashtra 400080.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
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
    );
  }
}

class _forContact extends StatelessWidget {
  const _forContact({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            const phoneNumber = '+91 9699270270';
            const url = 'tel:$phoneNumber';

            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            }
          },
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(CupertinoIcons.phone, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "+91 9699270270",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _forEmailSupport extends StatelessWidget {
  const _forEmailSupport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            const toEmail = 'support@multicraft.in';

            const url = 'mailto:$toEmail';
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            }
          },
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(CupertinoIcons.mail_solid, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "support@multicraft.in",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
