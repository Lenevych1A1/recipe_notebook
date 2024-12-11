import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'add_recipe.dart';
import 'recipe_model.dart';
import 'recipe_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? recipesData = prefs.getString('recipes');
    if (recipesData != null) {
      final List<dynamic> decodedData = jsonDecode(recipesData);
      setState(() {
        recipes = decodedData.map((data) => Recipe.fromJson(data)).toList();
      });
    }
  }

  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(recipes.map((r) => r.toJson()).toList());
    await prefs.setString('recipes', encodedData);
  }

  void _addRecipe(Recipe newRecipe) {
    setState(() {
      recipes.add(newRecipe);
    });
    _saveRecipes();
  }

  void _deleteRecipe(int index) {
    setState(() {
      recipes.removeAt(index);
    });
    _saveRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Записник рецептів'),
      ),
      body: recipes.isEmpty
          ? const Center(child: Text('Немає доданих рецептів'))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Dismissible(
                  key: Key(recipe.title),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteRecipe(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Рецепт "${recipe.title}" видалено')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(recipe.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailPage(recipe: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipePage(
                onAdd: (newRecipe) {
                  _addRecipe(newRecipe);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
