import 'package:flutter/material.dart';
import 'package:lovemug_app/core/constants/variables.dart';
import 'package:lovemug_app/core/pallette/pallete.dart';



class TalktimeOffersScreen extends StatelessWidget {
  // Simulated talktime offers list (replace with API data if needed)
  final List<TalktimeOffer> offers = [
    TalktimeOffer(amount: 50, talktime: 55, validity: "28 Days"),
    TalktimeOffer(amount: 100, talktime: 120, validity: "30 Days"),
    TalktimeOffer(amount: 200, talktime: 250, validity: "60 Days"),
    TalktimeOffer(amount: 500, talktime: 600, validity: "90 Days"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Talktime Recharge Offers",style: poppinsTextStyle(color: Colors.white,fontSize: width*0.05),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              leading: Icon(Icons.local_offer, color: Colors.purple, size: 35),
              title: Text(
                "₹${offer.amount} Recharge",
                style: poppinsTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Talktime: ₹${offer.talktime}", style: TextStyle(color: Colors.green)),
                  Text("Validity: ${offer.validity}", style: TextStyle(color: Colors.grey)),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Navigate to payment or recharge function
                  _showRechargeDialog(context, offer);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Buy", style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showRechargeDialog(BuildContext context, TalktimeOffer offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Recharge"),
          content: Text("Do you want to recharge ₹${offer.amount} for ₹${offer.talktime} talktime?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Recharge Successful for ₹${offer.amount}")),
                );
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}

// Model Class for Talktime Offer
class TalktimeOffer {
  final double amount;
  final double talktime;
  final String validity;

  TalktimeOffer({required this.amount, required this.talktime, required this.validity});
}
