import 'dart:convert';

class Recipe {
  final String id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
    );
  }
}

class RecipeList {
  final List<Recipe> recipes;

  RecipeList({
    required this.recipes,
  });

  factory RecipeList.fromJson(String json) {
    List<dynamic> jsonData = jsonDecode(json);
    List<Recipe> recipes = jsonData.map((recipe) => Recipe.fromJson(recipe)).toList();
    return RecipeList(recipes: recipes);
  }
}