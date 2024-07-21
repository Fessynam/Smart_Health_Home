import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedPeriod = 'Today';
  int caloriesConsumed = 1234;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthyHome'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMealsSection(),
                  const SizedBox(height: 24),
                  _buildRemediesSection(),
                  const SizedBox(height: 24),
                  _buildHealthSummarySection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, User!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Let\'s keep you healthy today!',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Meals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _mealBox('Breakfast', '7:00 AM')),
            SizedBox(width: 16),
            Expanded(child: _mealBox('Lunch', '12:30 PM')),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _mealBox('Dinner', '7:00 PM')),
            SizedBox(width: 16),
            Expanded(child: _addMealBox()),
          ],
        ),
      ],
    );
  }

  Widget _mealBox(String mealName, String time) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(mealName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(time, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _addMealBox() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement add meal functionality
        print('Add meal tapped');
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Center(
          child: Icon(Icons.add_circle_outline, size: 40, color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildRemediesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Natural Remedies & Tips', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.orange, size: 40),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tip of the Day', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Drink ginger tea to boost your immunity and aid digestion.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Health Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _buildPeriodButtons(),
        SizedBox(height: 24),
        _buildCaloriesSummary(),
        SizedBox(height: 24),
        _buildNutritionSummary(),
      ],
    );
  }

  Widget _buildPeriodButtons() {
    return Row(
      children: ['Today', 'Weekly', 'Monthly', 'Year'].map((period) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              onPressed: () => setState(() => selectedPeriod = period),
              child: Text(period),
              style: ElevatedButton.styleFrom(
                foregroundColor: selectedPeriod == period ? Colors.white : Colors.black, backgroundColor: selectedPeriod == period ? Colors.green : Colors.grey[300],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCaloriesSummary() {
    return Center(
      child: Column(
        children: [
          Text(
            '$caloriesConsumed',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          Text('Calories Consumed', style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildNutritionSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _nutritionBox('30%', 'Protein', Colors.blue),
        _nutritionBox('50%', 'Carbs', Colors.orange),
        _nutritionBox('20%', 'Fat', Colors.red),
      ],
    );
  }

  Widget _nutritionBox(String percentage, String label, Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(percentage, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}