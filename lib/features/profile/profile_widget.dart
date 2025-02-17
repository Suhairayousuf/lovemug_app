import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_app/features/profile/settings/screens/settings_widget.dart';
import 'package:lovemug_app/features/profile/talktime/screens/talktime_recharge_widget.dart';
import 'package:lovemug_app/features/profile/talktime/screens/talktime_transaction.dart';
import 'package:lovemug_app/features/profile/ticket_system/screens/ticket_history.dart';
import 'package:lovemug_app/features/profile/ticket_system/screens/add_new_ticket.dart';

import '../../core/constants/variables.dart';
import '../Home/screens/navigation_page.dart';
import 'blocked_list.dart';
import 'edit_profile.dart';
import 'expense/screens/expense_overview.dart';



class ProfileWidget extends StatefulWidget {
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
   // var width= MediaQuery.of(context).size.width;
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

        body: Column(
          children: [
             SizedBox(height: 10,),
            _buildProfileHeader(),

            _buildMenuItem(Icons.phone, "Talktime Transactions",1),
            SizedBox(height: 10,),

            _buildMenuItem(Icons.call, "Talktime",2, trailingText: "₹0",),
            SizedBox(height: 10,),

            _buildMenuItem(Icons.receipt, "Ticket System",3),
            SizedBox(height: 10,),
            _buildMenuItem(Icons.track_changes, "Expense Overview",4),
            SizedBox(height: 10,),

            _buildMenuItem(Icons.block, "Blocked & Hidden List",5),
            SizedBox(height: 10,),

            _buildMenuItem(Icons.settings, "Settings",6, showRedDot: true,),
            SizedBox(height: 10,),
            // _buildMenuItem(Icons.delete, "Delete Account",7, showRedDot: true,),
            // SizedBox(height: 10,),

            _buildUserId(width:width),
            SizedBox(height: 15,),

            _buildVersionId(width:width),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        // height: 130,
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
                Container(
                  width: width*0.3,
                  child: Text("user39731957",
                      style: poppinsTextStyle(color: Colors.white, fontSize: width*0.04, )),
                ),
                Text("Male, 25", style: poppinsTextStyle(color: Colors.white70, fontSize: width*0.035,fontWeight: FontWeight.w600)),
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
                  onPressed: () async {
                    final updatedData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          name: "user39731957",
                          about: "Male, 25",
                          profileImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTecaUSem5pKm6IOdlaUjz-2XTGd5wkZnzoNQ&s",
                        ),
                      ),
                    );
                              //                   if (updatedData != null) {
                              // setState(() {
                              // // userName = updatedData['name'];
                              // // userAbout = updatedData['about'];
                              // // userProfileImage = updatedData['profileImage'];
                              // });
                              // }

                  },
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.white24,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("EDIT", style: poppinsTextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketHistoryScreen()));


          }else if(type==4){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TalktimeExpenseScreen()));


          }
          else if(type==5) {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockedListScreen()));

          }else if(type==6){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));

          }
          // else{
          //   _softDeleteAccount(context);
          // }

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
      padding: EdgeInsets.only(top: width*0.3),
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
  Widget _buildVersionId({required width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "v:0.01",
          style: poppinsTextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),
        ),
      ],
    );
  }
}
