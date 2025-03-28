import 'package:flutter/material.dart';

import 'features/Home/screens/navigation_page.dart';
import 'features/auth/google_sign_in.dart';

// import 'features/Home/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home: GoogleSignInPage(),

    );
  }
}


