import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/admin_provider.dart';
import 'package:right_to_pride/providers/user_auth_provider.dart';
import 'package:right_to_pride/providers/user_provider.dart';
import 'screens/choose_user_screen.dart';

void main() {
  runApp(const RightToPride());
}

class RightToPride extends StatelessWidget {
  const RightToPride({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminProvider>(create: (_) => AdminProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider.value(
          value: UserAuthProvider(),
        )
      ],
      child: MaterialApp(
        home: ChooseUserScreen(),
        // theme: ThemeData.dark().copyWith(
        //   primaryColor: Colors.teal,
        //   primaryColorDark: Colors.teal,
        //   appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        //   scaffoldBackgroundColor: Colors.black,
        // ),
      ),
    );
    ;
  }
}
