import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String about;
  final String profileImage;

  EditProfileScreen({required this.name, required this.about, required this.profileImage});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _aboutController;
  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _aboutController = TextEditingController(text: widget.about);
    _imageUrl = widget.profileImage;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      _imageUrl = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: GoogleFonts.poppins(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
            children: [
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : (_imageUrl != null ? NetworkImage(_imageUrl!) : null) as ImageProvider?,
                      child: _imageFile == null && _imageUrl == null
                          ? Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.purple, size: 20),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Remove Image Button
              if (_imageFile != null || _imageUrl != null)
                TextButton(
                  onPressed: _removeImage,
                  child: Text("Remove Image", style: TextStyle(color: Colors.red)),
                ),

              SizedBox(height: 20),

              // Name Input
              Container(
                constraints: BoxConstraints(maxHeight: 60), // Prevents overflow
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10),

              // About Input
              Container(
                constraints: BoxConstraints(maxHeight: 80), // Prevents overflow
                child: TextField(
                  controller: _aboutController,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: "About", border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'about': _aboutController.text,
                    'profileImage': _imageFile != null ? _imageFile!.path : _imageUrl
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: Text("Save", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20), // Add extra space at the bottom to prevent overflow
            ],
          ),
        ),
      ),
    );
  }
}
