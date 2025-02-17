import 'package:flutter/material.dart';
import 'package:lovemug_app/core/pallette/pallete.dart';

import '../../../core/constants/variables.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) =>
              AlertDialog(
                title:  Text('Are you sure?',style: poppinsTextStyle(color: primaryColor)),
                content:  Text('Do you really want to Exit?',style: poppinsTextStyle()),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No',style: poppinsTextStyle(color: primaryColor)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child:  Text('Yes',style: poppinsTextStyle(color: primaryColor),),
                  ),
                ],
              ),
        );
        return shouldPop ?? false;
      },

      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text('HOME',style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
    );
  }
}
