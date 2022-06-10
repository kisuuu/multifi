import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multifi/screens/all_time_splash_screen.dart';
import 'package:multifi/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),

        // textTheme:
        //     GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
      ),
      initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
      routes: {
        'home': (context) => const AllTimeSplashScreen(),
        'onboard': (context) => const SplashScreen(),
      },
    );
  }
}
