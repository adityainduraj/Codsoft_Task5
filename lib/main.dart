import 'package:flutter/material.dart';
import 'recipes.dart';
import 'dart:convert'; // Added for json.encode

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecipeListPage(),
    );
  }
}

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  final recipeListJson = json.encode([
    {
      'id': '1',
      'name': 'Spaghetti Bolognese',
      'ingredients': ['Spaghetti', 'Minced Beef', 'Tomatoes', 'Onion', 'Garlic'],
      'instructions': [
        'Boil the spaghetti until cooked',
        'Fry the minced beef yowith the onion and garlic',
        'Add the tomatoes and simmer for 20 minutes',
        'Serve the spaghetti with the bolognese sauce'
      ],
    },
    {
      'id': '2',
      'name': 'Chocolate Cake',
      'ingredients': ['Flour', 'Cocoa Powder', 'Sugar', 'Eggs', 'Butter'],
      'instructions': [
        'Preheat the oven to 180°C',
        'Mix the flour, cocoa powder, sugar, eggs, and butter in a bowl',
        'Pour the mixture into a greased cake tin',
        'Bake in the oven for 25 minutes',
        'Remove from the oven and allow to cool',
        'Serve with whipped cream or ice cream'
      ],
    },
  ]);

  late final RecipeList _recipeList;

  final _searchController = TextEditingController();
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    // Initialize _recipeList within initState:
    _recipeList = RecipeList.fromJson(recipeListJson);
    _filteredRecipes = _recipeList.recipes;
  }

  // ... rest of the code remains unchanged


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Recipes',
              ),
              onChanged: (value) => _filterRecipes(value),
            ),
          ),
          Expanded(
            child: ListView(
              children: _filteredRecipes.map((recipe) {
                return ListTile(
                  title: Text(recipe.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(recipe: recipe),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _filterRecipes(String value) {
    setState(() {
      _filteredRecipes = _recipeList.recipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          ...recipe.ingredients.map((ingredient) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ingredient),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Instructions:',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          ...recipe.instructions.map((instruction) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(instruction),
            );
          }).toList(),
        ],
      ),
    );
  }
}