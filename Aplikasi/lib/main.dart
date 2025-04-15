import 'package:aplikasi/Detail_Jasa/detail_jasa.dart';
import 'package:aplikasi/Homepage/homepage.dart';
import 'package:aplikasi/Homepage/wishlist.dart';
import 'package:aplikasi/LoginScreen/welcome.dart';
import 'package:aplikasi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/LoginScreen/login.dart';
import 'package:aplikasi/LoginScreen/signup.dart';
import 'package:aplikasi/LoginScreen/forgotpassword.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
      initialRoute: Welcome.routeName,
      routes: {
        Welcome.routeName: (context) => Welcome(),
        Login.routeName: (context) => Login(),
        SignUp.routeName: (context) => SignUp(),
        Forgotpassword.routeName: (context) => Forgotpassword(),
        Homepage.routeName: (context) => Homepage(),
        WishlistPage.routeName: (context) => WishlistPage(),
        DetailJasa.routeName: (context) => DetailJasa(),
      },
    );
  }
}
