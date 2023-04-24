import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mealapp/containers/food_card.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
class CompareScreen extends StatelessWidget {


  const CompareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mealOneId = FoodCard.compareItemId, mealTwoId = FoodCard.comparingToItemId;
    Meal meal1 = DUMMY_MEALS.firstWhere((element) => element.id == mealOneId );
    Meal meal2 = DUMMY_MEALS.firstWhere((element) => element.id == mealTwoId );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              FoodView(meal: meal1),
              FoodView(meal: meal2)
          ],
        ),
      ),
    );
  }
}

class FoodView extends StatelessWidget {
  Meal meal;
  FoodView({Key? key, required this.meal}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle propStyle = const TextStyle(fontFamily: "Poppins", fontSize: 16);
    return  Container(
      width: size.width/2.3,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListBody(
            mainAxis: Axis.vertical,
              children: <Widget>[
                CachedNetworkImage(imageUrl: meal.imageUrl, width: size.width/3.8, height: size.height/4.8, fit: BoxFit.fill,),
                const SizedBox(height: 10,),
                Text("Name: ${meal.title}", style: propStyle,),
                const SizedBox(height: 10,),
                Text("Price: ${meal.price}", style: propStyle,),
                const SizedBox(height: 10,),
                Text("Is vegan: ${meal.isVegan}", style: propStyle,),
                const SizedBox(height: 10,),
                Text("Is vegetarian: ${meal.isVegetarian}", style: propStyle,),
                const SizedBox(height: 10,),
                Text("Is gluten free: ${meal.isGlutenFree}", style: propStyle,),
                const SizedBox(height: 10,),
                Text("Is lactose free: ${meal.isLactoseFree}", style: propStyle,),
                const SizedBox(height: 10,),
                Flexible(child: Text("Ingredients: ${meal.ingredients.join(", ")}", style: propStyle,)),
                const SizedBox(height: 10,),

              ],
          ),
        ),
      ),
    );
  }
}

