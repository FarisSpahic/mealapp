import 'package:flutter/material.dart';
import 'package:mealapp/containers/checkout_card.dart';
import 'package:mealapp/data/discounts.dart';
import 'package:mealapp/models/meal.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static List<Meal> CART_ITEMS = [];
  
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _refresh(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    List<CheckoutCard> items = CartScreen.CART_ITEMS.map((e) => CheckoutCard(meal: e, refresh: _refresh,)).toList();
    double priceToPay = 0;
    CartScreen.CART_ITEMS.forEach((element) {
      if(DISCOUNTS.containsKey(element.id)){
        int? per = DISCOUNTS[element.id];
        priceToPay += element.price - (element.price * (per! / 100));
      }else{
        priceToPay+=element.price;
      }
    });

    priceToPay = double.parse((priceToPay).toStringAsFixed(2));
    String total = priceToPay != 0 ? "Total: $priceToPay\$" : "No products in the cart...";
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Padding(padding: const EdgeInsets.all(5),
      child:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 5,),
            const Text("Checkout", style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 12,),
            Column(
              children: items,
            ),
            const SizedBox(height: 12,),
            Text(total, style: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      ),
    );
  }
}
