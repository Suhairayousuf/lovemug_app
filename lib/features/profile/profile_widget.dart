import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_app/features/profile/settings/screens/settings_widget.dart';
import 'package:lovemug_app/features/profile/talktime_recharge_widget.dart';
import 'package:lovemug_app/features/profile/talktime_transaction.dart';

import 'blocked_list.dart';



class ProfileWidget extends StatefulWidget {
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
   var width= MediaQuery.of(context).size.width;
    return Scaffold(

      body: Column(
        children: [
           SizedBox(height: 10,),
          _buildProfileHeader(),

          _buildMenuItem(Icons.phone, "Talktime Transactions",1),
          SizedBox(height: 10,),

          _buildMenuItem(Icons.call, "Talktime",2, trailingText: "₹0",),
          SizedBox(height: 10,),

          // _buildMenuItem(Icons.emoji_events, "Levels"),
          SizedBox(height: 10,),

          _buildMenuItem(Icons.block, "Blocked & Hidden List",3),
          SizedBox(height: 10,),

          _buildMenuItem(Icons.settings, "Settings",4, showRedDot: true,),
          SizedBox(height: 10,),

          _buildUserId(width:width),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 130,
         padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20),top: Radius.circular(20) ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(""
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTecaUSem5pKm6IOdlaUjz-2XTGd5wkZnzoNQ&s"), // Replace with actual profile image
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("user39731957",
                    style: TextStyle(color: Colors.white, fontSize: 19, )),
                Text("Male, 25", style: TextStyle(color: Colors.white70, fontSize: 14,fontWeight: FontWeight.w600)),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                //   decoration: BoxDecoration(
                //     color: Colors.blue,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: Text("Level 0", style: TextStyle(color: Colors.white, fontSize: 12)),
                // ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0,left: 20),
              child: Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.white24,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("EDIT", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,int type, {String? trailingText, bool showRedDot = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple,size: 30,),
      title: InkWell(
        onTap: (){
          if(type==1){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TalktimeTransactionsScreen()));

          }else if(type==2){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TalktimeOffersScreen()));

          }else if(type==3){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockedListScreen()));

          }else {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));

          }

        },
          child: Text(title, style: GoogleFonts.poppins(fontSize: 19))),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null) Text(trailingText, style: GoogleFonts.poppins(color: Colors.green)),
          // if (showRedDot)
          //   Padding(
          //     padding: const EdgeInsets.only(left: 8),
          //     child: Icon(Icons.circle, color: Colors.red, size: 8),
          //   ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildUserId({required width}) {
    return Padding(
      padding: EdgeInsets.only(top: width*0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "ID: 39731957",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
