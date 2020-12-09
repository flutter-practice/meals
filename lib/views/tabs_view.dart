import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/views/categories_view.dart';
import 'package:meals/views/favorite_view.dart';

class TabsView extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsView(this.favoriteMeals);

  @override
  _TabsViewState createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  int _selectedViewIndex = 0;
  List<Map<String, Object>> _views;

  @override
  void initState() {
    super.initState();
    _views = [
      {'title': 'Let\'s cook?', 'screen': CategoriesView()},
      {'title': 'Favorites', 'screen': FavoriteView(widget.favoriteMeals)},
    ];
  }

  _selectView(int index) {
    setState(() {
      _selectedViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_views[_selectedViewIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _views[_selectedViewIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectView,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedViewIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
