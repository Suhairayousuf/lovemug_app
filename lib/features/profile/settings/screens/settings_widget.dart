import 'package:flutter/material.dart';



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool doNotDisturb = false;
  bool isPoliciesExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Do Not Disturb Switch
          // _buildSwitchTile("Do not disturb", doNotDisturb, (value) {
          //   setState(() {
          //     doNotDisturb = value;
          //   });
          // }),

          // Upload Logs
          // _buildSimpleListTile("Upload logs", Icons.cloud_upload),

          // Expandable Our Policies Section
          _buildExpandablePolicies(),

          // Report a Problem
          Divider(),
          _buildSimpleListTile("Report a problem"
              // Icons.report
          ),

          // Delete Account
          _buildSimpleListTile("Delete Account"
              // Icons.delete, textColor: Colors.red
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // Widget _buildSimpleListTile(String title, IconData icon, {Color textColor = Colors.black}) {
  Widget _buildSimpleListTile(String title, {Color textColor = Colors.black}) {
    return ListTile(
      // leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: TextStyle(fontSize: 16, color: textColor)),
      onTap: () {
        // Implement functionality
      },
    );
  }

  Widget _buildExpandablePolicies() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        title: Text("Our Policies", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        initiallyExpanded: isPoliciesExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            isPoliciesExpanded = expanded;
          });
        },
        children: [
          _buildPolicyItem("Privacy Policy"),
          _buildPolicyItem("Terms of Use"),
          _buildPolicyItem("Delivery, Refund And Cancellation Policy"),
          _buildPolicyItem("Community Guidelines"),
          _buildPolicyItem("Compliance Statement"),
          _buildPolicyItem("Content Moderation Policy"),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(String title) {
    return ListTile(
      leading: Icon(Icons.circle, size: 8, color: Colors.black), // Small bullet point

      title: Text("$title", style: TextStyle(fontSize: 16)),
      onTap: () {
        // Navigate to the policy page
      },
    );
  }
}
