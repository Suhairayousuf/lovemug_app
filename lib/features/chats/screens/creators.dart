import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/variables.dart';
import '../../../core/pallette/pallete.dart';
import 'creator_chat_page.dart';

class CreatorWidget extends StatefulWidget {
  const CreatorWidget({super.key});

  @override
  State<CreatorWidget> createState() => _CreatorWidgetState();
}

class _CreatorWidgetState extends State<CreatorWidget> {
  List<User> users = [];
  bool isLoading = true;
  final User currentUser = User(name: "Creator", profilePic: "https://via.placeholder.com/150", time: "Now", id: '0');
  final String apiUrl = "https://yourapi.com/api/users"; // Update with actual API URL

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        try {
          List<dynamic> userData = jsonDecode(response.body);
          setState(() {
            users = userData.map((data) => User.fromJson(data)).toList();
            isLoading = false;
          });
        } catch (e) {
          print("JSON Parsing Error: $e");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        throw Exception("Failed to load users: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching users: $error");
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('CREATORS', style: poppinsTextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? Center(child: Text("No users found"))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatorChatPage(selectedUser: user, currentUser: currentUser),
                ),
              );
            },
            child: Card(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: width * 0.018, horizontal: width * 0.03),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person, color: Colors.white, size: width * 0.08),
                        ),
                        SizedBox(width: width * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * 0.036,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'message',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(user.time, style: poppinsTextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: width * 0.023),
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
