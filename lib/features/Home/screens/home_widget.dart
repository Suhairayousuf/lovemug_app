import 'package:flutter/material.dart';
import 'package:lovemug_app/core/pallette/pallete.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text('HOME',style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
    );
  }
}
