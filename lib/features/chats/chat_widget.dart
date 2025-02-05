import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/pallette/pallete.dart';
import '../../core/utils/utils.dart';
import '../Home/screens/navigation_page.dart';
import '../creators/screens/creators.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
   var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text('CHATS',style: TextStyle(color: Colors.white,fontSize: 20),),

      ),
      body: Center(
        child: Container(
          child: Text('No data Found'),
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding:  EdgeInsets.all(width*0.05),
          child: SizedBox(
            height: width*0.12,
            width: width*0.35,
            child: FloatingActionButton.extended(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              backgroundColor: primaryColor,
              onPressed: () async {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatorWidget()));


                // Handle the button press

              },
              label: Row(
                children: [
                  Icon(Icons.add,color: Colors.white,),
                  SizedBox(width: width*0.02),
                  Text(
                    "Start Chat",
                    style: GoogleFonts.inter(fontSize: width*0.04,color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
