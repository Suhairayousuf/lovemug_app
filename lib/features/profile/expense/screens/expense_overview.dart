import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_app/core/constants/variables.dart';

class TalktimeExpenseScreen extends StatefulWidget {
  @override
  _TalktimeExpenseScreenState createState() => _TalktimeExpenseScreenState();
}

class _TalktimeExpenseScreenState extends State<TalktimeExpenseScreen> {
  List<Map<String, dynamic>> expenses = [
    {"category": "Talktime", "amount": 500.0, "date": DateTime(2024, 2, 1)},
    {"category": "Talktime", "amount": 700.0, "date": DateTime(2024, 2, 3)},
    {"category": "Talktime", "amount": 1200.0, "date": DateTime(2024, 2, 5)},
    {"category": "Talktime", "amount": 800.0, "date": DateTime(2024, 2, 7)},
    {"category": "Talktime", "amount": 1100.0, "date": DateTime(2024, 2, 9)},
    {"category": "Talktime", "amount": 650.0, "date": DateTime(2024, 2, 11)},
  ];
  String selectedDuration = 'Month'; // Default duration

  // Function to change the selected duration
  void _changeDuration(String duration) {
    setState(() {
      selectedDuration = duration;
    });
  }
  // 🔹 Get all Talktime expenses without filtering
  List<Map<String, dynamic>> getAllExpenses() {
    return expenses;
  }

  // 🔹 Generate Line Chart Data for Date on X-axis and Amount on Y-axis
  List<FlSpot> getChartData() {
    List<Map<String, dynamic>> allExpenses = getAllExpenses();

    if (allExpenses.isEmpty) {
      return [FlSpot(0, 0)]; // Ensures graph renders even if no data
    }

    return allExpenses
        .map((expense) {
      // Convert DateTime to a numeric value for X-axis (milliseconds since epoch)
      double xValue = expense["date"].millisecondsSinceEpoch.toDouble();
      double yValue = expense["amount"].toDouble();
      return FlSpot(xValue, yValue);
    })
        .toList();
  }
  List<Map<String, dynamic>> getFilteredExpenses() {
    DateTime now = DateTime.now();
    if (selectedDuration == 'Day') {
      return expenses.where((expense) {
        DateTime expenseDate = expense["date"];
        return expenseDate.year == now.year && expenseDate.month == now.month && expenseDate.day == now.day;
      }).toList();
    } else if (selectedDuration == 'Month') {
      return expenses.where((expense) {
        DateTime expenseDate = expense["date"];
        return expenseDate.year == now.year && expenseDate.month == now.month;
      }).toList();
    } else if (selectedDuration == 'Year') {
      return expenses.where((expense) {
        DateTime expenseDate = expense["date"];
        return expenseDate.year == now.year;
      }).toList();
    }
    return [];
  }

  // Calculate total expense for the selected duration
  double getTotalExpense() {
    List<Map<String, dynamic>> filteredExpenses = getFilteredExpenses();
    return filteredExpenses.fold(0, (sum, item) => sum + item["amount"]);
  }


  @override
  Widget build(BuildContext context) {
    double totalSpent = getTotalExpense();
    List<Map<String, dynamic>> allExpenses = getAllExpenses();
    List<FlSpot> chartData = getChartData();

    return Scaffold(
      appBar: AppBar(title: Text("Expense Overview",style: GoogleFonts.poppins(color: Colors.white),), backgroundColor: Colors.purple,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _changeDuration('Day'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    color: selectedDuration == 'Day' ? Colors.purple : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Day",
                    style: poppinsTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8), // Spacing between buttons
              GestureDetector(
                onTap: () => _changeDuration('Month'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    color: selectedDuration == 'Month' ? Colors.purple : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Month",
                    style: poppinsTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8), // Spacing between buttons
              GestureDetector(
                onTap: () => _changeDuration('Year'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    color: selectedDuration == 'Year' ? Colors.purple : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Year",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Total Talktime Expense", style: poppinsTextStyle(fontSize: width*0.04, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("₹${totalSpent.toStringAsFixed(2)}", style: poppinsTextStyle(fontSize: width*0.045, color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          SizedBox(height: 10,),
          // 🔹 Line Chart for Talktime Expenses (Date on X-axis and Amount on Y-axis)
          Container(
            height: 250,
            padding: EdgeInsets.all(10),
            child: LineChart(
              LineChartData(
                minX: chartData.isEmpty ? 0 : chartData.first.x,
                maxX: chartData.isEmpty ? 1 : chartData.last.x,
                minY: 0,
                maxY: chartData.isEmpty ? 1 : chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 100, // Adjust Y-axis max value
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    color: Colors.purple, // Line color
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.purple.withOpacity(0.3), // Shading below the line
                    ),
                    dotData: FlDotData(show: false),
                  ),
                ],

                titlesData: FlTitlesData(
                  topTitles: AxisTitles( // Hide top X-axis labels
                    sideTitles: SideTitles(
                      showTitles: false, // This removes the cluttered top labels
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                        return Text("${date.day}/${date.month}", style: TextStyle(fontSize: 12));
                      },
                      reservedSize: 22,
                    ),
                  ),
                ),


                gridData: FlGridData(show: true),

              ),
            ),
          ),

          // 🔹 Expense List for Talktime (All Data)
          Expanded(
            child: allExpenses.isEmpty
                ? Center(child: Text("No Talktime expenses available."))
                : ListView.builder(
              itemCount: allExpenses.length,
              itemBuilder: (context, index) {
                var expense = allExpenses[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.phone, color: Colors.white),
                    ),
                    title: Text("₹${expense["amount"]}",style: poppinsTextStyle(),),
                    subtitle: Text(
                      "${expense["date"].day}-${expense["date"].month}-${expense["date"].year}",style: poppinsTextStyle( fontSize: width*0.02,),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
