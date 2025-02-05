import 'package:flutter/material.dart';



class BlockedListScreen extends StatefulWidget {
  @override
  _BlockedListScreenState createState() => _BlockedListScreenState();
}

class _BlockedListScreenState extends State<BlockedListScreen> {
  // Simulated blocked creators list (replace with actual database fetch)
  List<User> blockedUsers = [
    User(name: "John Doe", profilePic: "https://via.placeholder.com/150"),
    User(name: "Alice Smith", profilePic: "https://via.placeholder.com/150"),
    User(name: "Michael Brown", profilePic: "https://via.placeholder.com/150"),
  ];

  void _unblockUser(int index) {
    setState(() {
      blockedUsers.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User unblocked successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: blockedUsers.isEmpty
          ? Center(
        child: Text("No blocked users found",
            style: TextStyle(fontSize: 18, color: Colors.grey)),
      )
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: blockedUsers.length,
        itemBuilder: (context, index) {
          final user = blockedUsers[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(""
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTecaUSem5pKm6IOdlaUjz-2XTGd5wkZnzoNQ&s"), // Replace with actual profile image
                // backgroundImage: NetworkImage(user.profilePic),
                radius: 25,
              ),
              title: Text(
                user.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () => _unblockUser(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Unblock", style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Model Class for User
class User {
  final String name;
  final String profilePic;

  User({required this.name, required this.profilePic});
}
