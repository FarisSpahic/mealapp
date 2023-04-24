import 'package:flutter/material.dart';
import 'package:mealapp/containers/food_card.dart';
import 'package:mealapp/data/dummy_data.dart';

class FoodGallery extends StatefulWidget {
  const FoodGallery({Key? key}) : super(key: key);

  @override
  State<FoodGallery> createState() => _FoodGalleryState();
}

class _FoodGalleryState extends State<FoodGallery> {
  final List<FoodCard> items = DUMMY_MEALS.map((e) => FoodCard(meal: e)).toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: items
      ),
    );
  }
}
