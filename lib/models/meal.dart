import 'package:flutter/cupertino.dart';

enum Complexity {
  Simple,
  Medium,
  Difficult,
}

enum Cost {
  Cheap,
  Fair,
  Expensive,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  final Complexity complexity;
  final Cost cost;

  const Meal({
    @required this.id,
    @required this.categories,
    @required this.title,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.complexity,
    @required this.cost,
  });

  String get complexityLabel {
    String label;
    switch (complexity) {
      case Complexity.Simple:
        label = 'Simple';
        break;
      case Complexity.Medium:
        label = 'Medium';
        break;
      case Complexity.Difficult:
        label = 'Difficult';
        break;
    }
    return label;
  }

  String get costLabel {
    String label;
    switch (cost) {
      case Cost.Cheap:
        label = 'Cheap';
        break;
      case Cost.Fair:
        label = 'Fair';
        break;
      case Cost.Expensive:
        label = 'Expensive';
        break;
    }
    return label;
  }
}
