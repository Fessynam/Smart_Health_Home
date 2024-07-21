import 'package:flutter/material.dart';

class RemedyScreen extends StatelessWidget {
  const RemedyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutSection(),
                  SizedBox(height: 24),
                  _buildHealsSection(),
                  SizedBox(height: 24),
                  _buildDirectionsSection(),
                  SizedBox(height: 24),
                  _buildPrepareButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Ginger Tea',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        background: Image.network(
          'https://t4.ftcdn.net/jpg/03/57/34/23/240_F_357342355_FIhhTeOlzO2xObSK20RTIOOywpXikdPp.jpg',
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
          'About Ginger Tea',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Ginger tea is a soothing and aromatic beverage known for its numerous health benefits. It has been used for centuries in traditional medicine to aid digestion, reduce inflammation, and boost immunity.',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildHealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Heals',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            _buildHealCard(Icons.healing, 'Nausea'),
            SizedBox(width: 16),
            _buildHealCard(Icons.sick, 'Cold & Flu'),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Ginger tea is known to alleviate nausea, reduce inflammation, and help fight cold and flu symptoms. It may also aid in digestion and boost overall immunity.',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildHealCard(IconData icon, String text) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.green),
              SizedBox(height: 8),
              Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDirectionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Directions',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _buildDirectionStep(1, 'Peel and slice fresh ginger root.'),
        _buildDirectionStep(2, 'Boil water in a pot or kettle.'),
        _buildDirectionStep(3, 'Add ginger to a cup and pour hot water over it.'),
        _buildDirectionStep(4, 'Let it steep for 5-10 minutes.'),
        _buildDirectionStep(5, 'Strain and add honey or lemon if desired.'),
      ],
    );
  }

  Widget _buildDirectionStep(int stepNumber, String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              instruction,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrepareButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement prepare remedy functionality
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Preparing your remedy...'))
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Prepare Remedy',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}