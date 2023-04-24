import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mealapp/data/discounts.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/cart_screen.dart';

class CheckoutCard extends StatefulWidget {
  Meal meal;
  Function refresh;
  CheckoutCard({Key? key, required this.meal, required this.refresh}) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {

  void _updateParent(){
    CartScreen.CART_ITEMS.remove(widget.meal);
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget priceText = Text("${widget.meal.price}\$", style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    ),);

    // define the discounted price
    if(DISCOUNTS.containsKey(widget.meal.id)){
      int? per = DISCOUNTS[widget.meal.id];
      double newprice = widget.meal.price - (widget.meal.price * (per! / 100));
      newprice = double.parse((newprice).toStringAsFixed(2));

      priceText = Row(
        children: [
          Text("${widget.meal.price}\$", style: const TextStyle(decoration: TextDecoration.lineThrough, fontWeight: FontWeight.normal, fontFamily: 'Poppins', fontSize: 18, color: Colors.black),),
          const SizedBox(width: 5,),
          Text("$newprice\$", style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 20, color: Colors.white),),
        ],
      );
    }
    return Container(
      width: size.width,
      height: size.height/7,
      decoration: const BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: CachedNetworkImage(imageUrl: widget.meal.imageUrl,fit: BoxFit.contain, width: size.width/3.8,)
              ),
              const SizedBox(width: 15,),
             priceText
            ],
          ),
          const Spacer(),
          GestureDetector(onTap: _updateParent,child: const Icon(Icons.delete),),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }
}
