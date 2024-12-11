import 'package:flutter/material.dart';
import 'recipe_model.dart';

class AddRecipePage extends StatelessWidget {
  final Function(Recipe) onAdd;

  const AddRecipePage({required this.onAdd, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final ingredientsController = TextEditingController();
    final instructionsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Додати рецепт'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Назва рецепта'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(labelText: 'Інгредієнти'),
              maxLines: 3,
            ),
            TextField(
              controller: instructionsController,
              decoration: const InputDecoration(labelText: 'Інструкції'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    ingredientsController.text.isNotEmpty &&
                    instructionsController.text.isNotEmpty) {
                  final newRecipe = Recipe(
                    title: titleController.text,
                    ingredients: ingredientsController.text,
                    instructions: instructionsController.text,
                  );
                  onAdd(newRecipe);
                  Navigator.pop(context);
                }
              },
              child: const Text('Додати'),
            ),
          ],
        ),
      ),
    );
  }
}
