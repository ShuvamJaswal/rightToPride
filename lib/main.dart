import 'package:flutter/material.dart';
import 'screens/choose_user_screen.dart';

void main() {
  runApp(const RightToPride());
}

class RightToPride extends StatelessWidget {
  const RightToPride({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChooseUserScreen(),
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}
