import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailView extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final Function(Meal) isFavorite;
  const MealDetailView(this.onToggleFavorite, this.isFavorite);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _createSectionWidget(Widget child, {double height = 250}) {
    return Container(
      width: 330,
      height: height,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    final appBar = AppBar(
      title: Text(meal.title),
    );
    final double statusBarHeight = mediaQuery.padding.top;
    final availableHeight =
        mediaQuery.size.height - appBar.preferredSize.height - statusBarHeight;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _createSectionTitle(context, 'Ingredients'),
            _createSectionWidget(
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                },
              ),
              height: (meal.steps.length * 65.0) + 10,
            ),
            _createSectionTitle(context, 'Steps'),
            _createSectionWidget(
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text((index + 1).toString()),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
              height: (meal.steps.length * 75.0),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
        onPressed: () {
          onToggleFavorite(meal);
        },
      ),
    );
  }
}
