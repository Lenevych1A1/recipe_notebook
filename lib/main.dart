import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const RecipeNotebookApp());
}

class RecipeNotebookApp extends StatelessWidget {
  const RecipeNotebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Записник рецептів',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
