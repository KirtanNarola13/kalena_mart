import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalena_mart/modules/screens/detail_screen.dart';
import 'package:kalena_mart/modules/screens/home_page.dart';
import 'package:kalena_mart/modules/screens/sign-up-screen/views/sign-up-screen.dart';
import 'firebase_options.dart';
import 'modules/screens/login-screen/view/login-screen.dart';
import 'modules/screens/one-time-intro/view/one-time-intro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true, textTheme: GoogleFonts.openSansTextTheme()),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      getPages: [
        // GetPage(
        //   name: '/',
        //   page: () => const SplashScreen(),
        // ),
        // GetPage(
        //   name: '/',
        //   page: () => IntroScreen(),
        // ),
        GetPage(
          name: '/',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/detail',
          page: () => DetailPage(),
        ),
      ],
    ),
  );
}
