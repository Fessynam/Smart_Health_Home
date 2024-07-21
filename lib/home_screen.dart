import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  String selectedPeriod = 'Today';
  int caloriesConsumed = 1234;
  String searchQuery = '';
  List<Meal> allMeals = [
    Meal('Grilled Chicken Salad', 'https://bing.com/th?id=OSK.661aa6abe4e321b243ee34db4b45bc1c'),
    Meal('Vegetable Stir Fry', 'https://th.bing.com/th/id/R.dbe7b9c9b422903d8b3b932f082dac6f?rik=2%2byVuXNBr%2fn5xA&pid=ImgRaw&r=0'),
    Meal('Salmon with Roasted Vegetables', 'https://th.bing.com/th/id/R.9d4b963d811b25920574222859a69d8a?rik=Vkx1rqMhIOZCgA&pid=ImgRaw&r=0'),
    Meal('Quinoa Buddha Bowl', 'https://th.bing.com/th/id/R.10b8b66e515f2d17211970b0c80c230f?rik=7jaM%2b3sPS7CoOg&riu=http%3a%2f%2fimages.media-allrecipes.com%2fuserphotos%2f960x960%2f4565089.jpg&ehk=R%2fOehHHQfDhtWQTGl0tW%2bbEQAMVeZ%2fl2BZCMecppEMM%3d&risl=&pid=ImgRaw&r=0'),
    Meal('Greek Yogurt Parfait', 'https://th.bing.com/th/id/R.a847e179c990961116cb839c8b198082?rik=cOOTboVAnFdxhA&pid=ImgRaw&r=0'),
    Meal('Avocado Toast with Egg', 'https://example.com/avocado_toast_egg.jpg'),
    Meal('Lentil Soup', 'https://example.com/lentil_soup.jpg'),
    Meal('Grilled Tofu Skewers', 'https://example.com/grilled_tofu_skewers.jpg'),
    Meal('Spinach and Feta Omelette', 'https://example.com/spinach_feta_omelette.jpg'),
    Meal('Turkey and Hummus Wrap', 'https://example.com/turkey_hummus_wrap.jpg'),
    Meal('Baked Sweet Potato with Black Beans', 'https://example.com/sweet_potato_black_beans.jpg'),
    Meal('Tuna Nicoise Salad', 'https://example.com/tuna_nicoise_salad.jpg'),
    Meal('Mushroom Risotto', 'https://example.com/mushroom_risotto.jpg'),
    Meal('Chicken and Vegetable Soup', 'https://example.com/chicken_vegetable_soup.jpg'),
    Meal('Whole Grain Pasta with Tomato Sauce', 'https://example.com/whole_grain_pasta_tomato.jpg'),
    Meal('Veggie Burger with Sweet Potato Fries', 'https://example.com/veggie_burger_fries.jpg'),
    Meal('Fruit and Nut Oatmeal', 'https://example.com/fruit_nut_oatmeal.jpg'),
    Meal('Grilled Shrimp Skewers', 'https://example.com/grilled_shrimp_skewers.jpg'),
    Meal('Caprese Sandwich', 'https://example.com/caprese_sandwich.jpg'),
    Meal('Stuffed Bell Peppers', 'https://example.com/stuffed_bell_peppers.jpg'),
  ];
  List<Meal> searchResults = [];// You'll need to define a Meal class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthyHome'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // TODO: Implement profile action
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings action
            },
          ),
        ],
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
                  _buildSearchResults(),
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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for meals...',
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
            searchResults = allMeals
                .where((meal) =>
                meal.name.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();
          });
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchQuery.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Results',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(searchResults[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      searchResults[index].name,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
// A search bar should be here
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
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 8, // Horizontal space between buttons
      runSpacing: 8, // Vertical space between rows if buttons wrap
      children: ['Today', 'Weekly', 'Monthly', 'Year'].map((period) {
        return IntrinsicWidth( // This ensures the button width is based on its content
          child: ElevatedButton(
            onPressed: () => setState(() => selectedPeriod = period),
            child: Text(period),
            style: ElevatedButton.styleFrom(
              foregroundColor: selectedPeriod == period ? Colors.white : Colors.black,
              backgroundColor: selectedPeriod == period ? Colors.green : Colors.grey[300],
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding as needed
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

class Meal {
  final String name;
  final String imageUrl;

  Meal(this.name, this.imageUrl);
}