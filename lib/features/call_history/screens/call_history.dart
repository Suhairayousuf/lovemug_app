import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_app/core/pallette/pallete.dart';

import '../../../core/constants/variables.dart';
import '../../Home/screens/navigation_page.dart';

class CallHistoryScreen extends StatefulWidget {
  @override
  _CallHistoryScreenState createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  // Example Call History Data (Hardcoded for now)
  List<Map<String, dynamic>> callHistory = [
    {"creator": "John Doe", "duration": "5m 30s", "type": Icons.keyboard_voice_outlined, "date": DateTime(2024, 2, 1)},
    {"creator": "Jane Smith", "duration": "3m 15s", "type": Icons.keyboard_voice_outlined, "date": DateTime(2024, 2, 3)},
    {"creator": "Alice Brown", "duration": "10m 0s", "type": Icons.video_call, "date": DateTime(2024, 2, 5)},
    {"creator": "Bob Johnson", "duration": "8m 45s", "type": Icons.keyboard_voice_outlined, "date": DateTime(2024, 2, 7)},
    {"creator": "Emily White", "duration": "12m 30s", "type": Icons.video_call, "date": DateTime(2024, 2, 9)},
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationBarPage(initialIndex: 0),
          ),
              (route) => false,
        );
        return false; // Returning false ensures the current page will not pop.
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Call History",style: GoogleFonts.poppins(color: Colors.white),), backgroundColor: Colors.purple),
        body: ListView.builder(
          itemCount: callHistory.length,
          itemBuilder: (context, index) {
            var call = callHistory[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Icon(Icons.phone, color: Colors.white),
                ),
                title: Text(call["creator"], style: poppinsTextStyle(fontWeight: FontWeight.bold)),
                subtitle: Row(
                  children: [
                    Icon(call["type"], color: primaryColor),  // Correct icon based on call type
                    SizedBox(width: 8), // Spacing between icon and text
                    Text("Duration: ${call["duration"]}",style: poppinsTextStyle(color: Colors.grey,fontSize: width*0.03),),
                  ],
                ),
                trailing: Text(
                  "${call["date"].day}-${call["date"].month}-${call["date"].year}",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
