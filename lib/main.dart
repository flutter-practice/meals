import 'package:flutter/material.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/views/settings_view.dart';
import 'utils/app_routes.dart';
import 'views/categories_meals_view.dart';
import 'views/meal_detail.view.dart';
import 'views/tabs_view.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  Settings settings = Settings();
  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        final glutenFilter = settings.isGlutenFree && !meal.isGlutenFree;
        final lactoseFilter = settings.isLactoseFree && !meal.isLactoseFree;
        final veganFilter = settings.isVegan && !meal.isVegan;
        final vegetarianFilter = settings.isVegetarian && !meal.isVegetarian;
        return !glutenFilter &&
            !lactoseFilter &&
            !vegetarianFilter &&
            !veganFilter;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isfavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsView(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsView(_availableMeals),
        AppRoutes.MEAL_DETAILS: (ctx) =>
            MealDetailView(_toggleFavorite, _isfavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsView(_filterMeals, settings),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return TabsView(_favoriteMeals);
          },
        );
      },
    );
  }
}
