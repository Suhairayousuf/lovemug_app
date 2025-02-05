import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_app/core/pallette/pallete.dart';



class TalktimeTransactionsScreen extends StatefulWidget {
  @override
  State<TalktimeTransactionsScreen> createState() => _TalktimeTransactionsScreenState();
}

class _TalktimeTransactionsScreenState extends State<TalktimeTransactionsScreen> {
  // Simulated transactions data (this should be replaced with actual database fetch)
  final List<TalktimeTransaction> transactions = [
    TalktimeTransaction(amountPaid: 100, talktimeReceived: 120, createdAt: DateTime(2025, 2, 1, 14, 30)),
    TalktimeTransaction(amountPaid: 200, talktimeReceived: 250, createdAt: DateTime(2025, 1, 28, 10, 45)),
    TalktimeTransaction(amountPaid: 50, talktimeReceived: 60, createdAt: DateTime(2025, 1, 25, 18, 10)),
    TalktimeTransaction(amountPaid: 500, talktimeReceived: 600, createdAt: DateTime(2025, 1, 20, 12, 15)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Talktime Transactions",style: GoogleFonts.poppins(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: transactions.isEmpty
          ? Center(child: Text("No Transactions Found", style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              leading: Icon(Icons.phone, color: Colors.purple, size: 35),
              title: Text(
                "₹${transaction.amountPaid} Paid",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Talktime Received: ₹${transaction.talktimeReceived}",
                      style: TextStyle(color: Colors.green)),
                  Text(
                    _formatDate(transaction.createdAt),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                // Handle transaction details click
              },
            ),
          );
        },
      ),
    );
  }

  // Function to format date in readable format
  String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
  }
}

// Model Class for Talktime Transactions
class TalktimeTransaction {
  final double amountPaid;
  final double talktimeReceived;
  final DateTime createdAt;

  TalktimeTransaction({required this.amountPaid, required this.talktimeReceived, required this.createdAt});
}
