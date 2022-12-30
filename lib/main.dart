import 'package:flutter/material.dart';
import 'package:shorts_clone/constants.dart';
import 'package:shorts_clone/views/screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube shorts Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: 'Product Sans',
      ).copyWith(scaffoldBackgroundColor: backgroundColor),
      home: LoginScreen(),
    );
  }
}
