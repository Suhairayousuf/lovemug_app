import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Home/screens/navigation_page.dart';


class GoogleSignInPage extends StatefulWidget {
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<void> _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? user = await _googleSignIn.signIn();
  //     if (user != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Signed in as ${user.displayName}')),
  //       );
  //     }
  //   } catch (error) {
  //     print('Sign in failed: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/Animation - 1739001153479.json',
              height: 200,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationBarPage()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/google (1).png',
                      height: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Google Sign In',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
