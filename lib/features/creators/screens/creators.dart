import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/pallette/pallete.dart';
import 'creator_chat_page.dart';

class CreatorWidget extends StatefulWidget {
  const CreatorWidget({super.key});

  @override
  State<CreatorWidget> createState() => _CreatorWidgetState();
}

class _CreatorWidgetState extends State<CreatorWidget> {
  final List<User> users = [
    User(name: "Susu", profilePic: "https://via.placeholder.com/150", time: "10:30 AM",id:"1"),
    User(name: "John Doe", profilePic: "https://via.placeholder.com/150", time: "11:00 AM",id:"2"),
    User(name: "Alice", profilePic: "https://via.placeholder.com/150", time: "12:15 PM",id:"3"),
  ];
  final User currentUser = User(name: "Creator", profilePic: "https://via.placeholder.com/150", time: "Now", id: '');

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(
         automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text('CREATORS',style: TextStyle(color: Colors.white,fontSize: 20),),

      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatorChatPage(selectedUser: user,currentUser:currentUser),
                ),
              );
            },
            child: Card(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: width * 0.018, horizontal: width * 0.03), // Adjust padding as needed
                child: Column(
                  children: [
                    // SizedBox(height: width * 0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out widgets
                      crossAxisAlignment: CrossAxisAlignment.center, // Align items in the center vertically
                      children: [
                        // Leading widget
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person, color: Colors.white, size: width * 0.08),
                        ),
                        SizedBox(width: width * 0.03), // Space between leading and title

                        // Title and Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                            children: [
                              Text(
                                user.name.toString(),
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: width * 0.036,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'message',
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: width * 0.03,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),
                        ),
                        Text(user.time),

                        // Trailing Actions

                      ],
                    ),
                    SizedBox(height: width * 0.023), // Space between items
                    // Divider(color: Colors.grey.shade300), // Add divider
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
class User {
  final String name;
  final String profilePic;
  final String time;
  final String id;

  User( {required this.name, required this.profilePic, required this.time,required this.id,});
}