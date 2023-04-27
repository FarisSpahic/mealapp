import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealapp/data/discounts.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/cart_screen.dart';
import 'package:mealapp/screens/compare_items_screen.dart';
class FoodCard extends StatefulWidget {
  final Meal meal;
  static String compareItemId = "", comparingToItemId = "";
  const FoodCard({Key? key, required this.meal}) : super(key: key);

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {



  String listConversion(List<Object> items){
    String output = "";
    for(Object item in items){
      output+="$item\n";
    }
    return output;
  }

  Future<void> _showCompareFoodDialog() async{
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
            Size size = MediaQuery.of(context).size;
            List<Widget> items = DUMMY_MEALS.map((e) => Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.pinkAccent,
              ),
              child: GestureDetector(
                onTap: (){FoodCard.comparingToItemId = e.id; Navigator.of(context).pop(); GoRouter.of(context).push('/comparison');},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(imageUrl: e.imageUrl, width: size.width/3.5, height: size.height/8.2 ,fit: BoxFit.fill,),
                    ),
                    const SizedBox(width: 15,),
                    Flexible(child: Text(e.title))
                  ],
                ),
              ),
            )).toList();
            return AlertDialog(

              backgroundColor: Colors.pink,
              content: SingleChildScrollView(
                child: ListBody(

                  children: items,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Close", style: TextStyle(color: Colors.white, fontSize: 18, )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )

              ],
            );
        });
  }
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink,
          titleTextStyle: const TextStyle(fontFamily: "Poppins", fontSize: 28),
          title:  Text(widget.meal.title),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                CachedNetworkImage(imageUrl: widget.meal.imageUrl),
                const Text("Categories: ", style: TextStyle(fontSize: 22, fontFamily: "Poppins"),),
                Text(listConversion(widget.meal.categories)),
                const Text("Affordability:",style: TextStyle(fontSize: 22, fontFamily: "Poppins"),),
                Text(widget.meal.affordability.name),
                const Text("Ingredients:",style: TextStyle(fontSize: 22, fontFamily: "Poppins"),),
                Text(listConversion(widget.meal.ingredients))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: (){
              Navigator.of(context).pop();
              _showCompareFoodDialog();
            }, child: const Text("Compare", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),)
            ),
            TextButton(
              child: const Text("Close", style: TextStyle(color: Colors.white, fontSize: 18, )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )

          ],
        );
      },
    );
  }
  Future<void> _addToCart() async{
    CartScreen.CART_ITEMS.add(widget.meal);
  }
  @override
  Widget build(BuildContext context) {
    Size data = MediaQuery.of(context).size;

    Widget priceText = Text("${widget.meal.price}\$", style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',

    ),);
    if(DISCOUNTS.containsKey(widget.meal.id)){
      int? per = DISCOUNTS[widget.meal.id];
      double newprice = widget.meal.price - (widget.meal.price * (per! / 100));
      newprice = double.parse((newprice).toStringAsFixed(2));

      priceText = Column(
        children: [
          Text("${widget.meal.price}\$", style: const TextStyle(decoration: TextDecoration.lineThrough, fontWeight: FontWeight.normal, fontFamily: 'Poppins', fontSize: 18),),
          Text("$newprice\$", style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 20, color: Colors.pink),),
        ],
      );
  }

    return  GestureDetector(
      onTap: (){
        _showAlertDialog();
        FoodCard.compareItemId=widget.meal.id;
      },
      onLongPress: _addToCart,
      child: Container(
        width:  data.width/3,
        height: data.height/3,
        margin: const EdgeInsets.only(left: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.black87
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Image.network(widget.meal.imageUrl, fit: BoxFit.fitHeight, height: data.height/7,),
              const SizedBox(height: 10,),
              Text(
                widget.meal.title,
                style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                  fontSize: 16
              ),
              ),
              const SizedBox(height: 10,),
              priceText
            ],
          ),
        ),
      ),
    );
  }
}
