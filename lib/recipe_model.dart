class Recipe {
  final String title;
  final String ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.instructions,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      ingredients: json['ingredients'],
      instructions: json['instructions'],
    );
  }
}
