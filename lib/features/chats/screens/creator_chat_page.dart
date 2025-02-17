import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lovemug_app/core/pallette/pallete.dart';

import '../../../core/constants/variables.dart';
import 'creators.dart';

class CreatorChatPage extends StatefulWidget {
  final User selectedUser;
  final User currentUser;

  const CreatorChatPage({super.key, required this.selectedUser, required this.currentUser});

  @override
  State<CreatorChatPage> createState() => _CreatorChatPageState();
}

class _CreatorChatPageState extends State<CreatorChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];

  /// Sends a chat message to the backend API
  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      String apiUrl = "https://yourapi.com/api/chats/send"; // Replace with actual API URL

      Message newMessage = Message(
        text: _messageController.text,
        fromUserId: widget.currentUser.id, // Replace with actual user ID
        toUserId: widget.selectedUser.id,  // Replace with actual user ID
      );

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(newMessage.toJson()),
        );

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          setState(() {
            messages.add(newMessage);
          });
          _messageController.clear();
        } else {
          print("Failed to send message: ${response.body}");
        }
      } catch (e) {
        print("Error sending message: $e");
      }
    }
  }

  /// Function to attach a file (To be implemented)
  void _attachFile() {
    print("File Attachment Clicked!");
  }

  /// Function to record voice (To be implemented)
  void _recordVoice() {
    print("Voice Recording Clicked!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        title: Row(
          children: [
            CircleAvatar(child: Icon(Icons.person)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.selectedUser.name,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(widget.selectedUser.time,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isCurrentUser = message.fromUserId == widget.currentUser.id;

                return Align(
                  alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message.text, style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  /// Chat input field with send button
  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.attach_file, color: Colors.grey), onPressed: _attachFile),
          IconButton(icon: Icon(Icons.mic, color: Colors.grey), onPressed: _recordVoice),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: primaryColor,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

/// Message model for chat messages
class Message {
  final String text;
  final String fromUserId;
  final String toUserId;

  Message({required this.text, required this.fromUserId, required this.toUserId});

  // Convert message object to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      "message": text,
      "from_user_id": fromUserId,
      "to_user_id": toUserId,
    };
  }
}

/// Dummy User model (Replace with actual User class)
class User {
  final String id;
  final String name;
  final String profilePic;
  final String time;

  User({required this.id, required this.name, required this.profilePic, required this.time});

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      profilePic: json['profilePic'] ?? 'https://via.placeholder.com/150',
      time: json['time'] ?? '',
    );
  }

  // Convert User object to JSON (if needed for sending data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePic': profilePic,
      'time': time,
    };
  }
}

