import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/admin_provider.dart';
import 'package:right_to_pride/providers/user_auth_provider.dart';
import 'package:right_to_pride/providers/user_provider.dart';
import 'package:right_to_pride/screens/intro/intro_page.dart';

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
      child: const MaterialApp(
        home: IntroPage(),
      ),
    );
  }
}
