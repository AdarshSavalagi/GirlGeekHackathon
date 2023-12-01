import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.id, required this.title});
  final int id;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 79, 59, 51),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
      ),
    );
  }
}
