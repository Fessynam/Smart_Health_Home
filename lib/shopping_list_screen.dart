import 'package:flutter/material.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<Ingredient> ingredients = [
    Ingredient('Chicken Breast', 500, 'g', 200),
    Ingredient('Broccoli', 300, 'g', 100),
    Ingredient('Olive Oil', 50, 'ml', 30),
    Ingredient('Brown Rice', 200, 'g', 500),
  ];

  List<Ingredient> shoppingCart = [];

  void _addNewIngredient() {
    setState(() {
      ingredients.add(Ingredient('New Item', 0, 'g', 0));
    });
  }

  void _showShoppingCart() {
    shoppingCart = ingredients.where((ingredient) => ingredient.isChecked).toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ShoppingCartScreen(shoppingCart: shoppingCart),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy Chicken Stir-Fry'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMealImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutSection(),
                  SizedBox(height: 24),
                  _buildIngredientsSection(),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addNewIngredient,
                    child: Text('Add New Ingredient'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showShoppingCart,
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildMealImage() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2021/05/Chicken-Stir-Fry-main-1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Healthy Chicken Stir-Fry',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'A nutritious and delicious meal packed with lean protein and vegetables. This stir-fry is quick to prepare and perfect for a healthy weeknight dinner.',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ...ingredients.map((ingredient) => _buildIngredientItem(ingredient)).toList(),
      ],
    );
  }

  Widget _buildIngredientItem(Ingredient ingredient) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ingredient.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Available: ${ingredient.available}${ingredient.unit}',
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${ingredient.amount}', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  DropdownButton<String>(
                    value: ingredient.unit,
                    items: ['mg', 'g', 'ml', 'l'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        ingredient.unit = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Checkbox(
              value: ingredient.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  ingredient.isChecked = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Ingredient {
  final String name;
  final int amount;
  String unit;
  final int available;
  bool isChecked;

  Ingredient(this.name, this.amount, this.unit, this.available, {this.isChecked = false});
}

class ShoppingCartScreen extends StatelessWidget {
  final List<Ingredient> shoppingCart;

  const ShoppingCartScreen({Key? key, required this.shoppingCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: shoppingCart.length,
        itemBuilder: (context, index) {
          final item = shoppingCart[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('${item.amount} ${item.unit}'),
            trailing: Text('Available: ${item.available} ${item.unit}'),
          );
        },
      ),
    );
  }
}