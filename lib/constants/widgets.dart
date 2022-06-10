// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:multifi/constants/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SkeltonContainer extends StatelessWidget {
  const SkeltonContainer({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.06),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}

class NewCardSkelton extends StatelessWidget {
  const NewCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Neumorphic(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _forSkeltonLeftHeading(),
                        _forSkeltonCenterHeading(),
                        _forSkeltonRightHeading()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _forSkeltonBottomContent()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _forSkeltonLeftHeading() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: SkeltonContainer(
              height: 15,
              width: 50,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: SkeltonContainer(
              height: 25,
              width: 85,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _forSkeltonCenterHeading() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: SkeltonContainer(
              height: 15,
              width: 50,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Align(
            alignment: Alignment.center,
            child: SkeltonContainer(
              height: 25,
              width: 85,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _forSkeltonRightHeading() {
    return Expanded(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: SkeltonContainer(
              height: 15,
              width: 50,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Align(
            alignment: Alignment.topRight,
            child: SkeltonContainer(
              height: 25,
              width: 85,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _forSkeltonBottomContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Align(
          child: SkeltonContainer(
            height: 15,
            width: 75,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Align(
          child: SkeltonContainer(
            height: 30,
            width: 85,
          ),
        ),
      ],
    );
  }
}

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: MainColor),
    hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
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
  );
}

// -----------------------button widget for choose plan---------------------------
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: const StadiumBorder(),
          primary: MainColor,
        ),
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        onPressed: onClicked,
      );
}

Widget builderHeader(BuildContext context, SheetState state) => Material(
      child: Container(
        color: MainColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 14,
            ),
            Center(
              child: Container(
                width: 32,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );

class PackageInfoApi {
  static Future<String> getAppVersion() async {
    PackageInfo packagesInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;

    return '${packagesInfo.version} + ${packagesInfo.buildNumber}';
  }
}
