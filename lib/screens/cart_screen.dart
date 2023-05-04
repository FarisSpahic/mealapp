import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  late final Box productsBox;

  void _refresh(){
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

    const snackBar = SnackBar(
      content: Text('Purchase has been made!', style: TextStyle(color: Colors.pink),),
    );

    Widget checkoutButton = (priceToPay != 0 ? Center(
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Purchase", style: TextStyle(color: Colors.pink, fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.bold),),
          ),
        ),

        onTap: () {
          //make transaction
          final transactionsBox = Hive.box("transactionsBox");
          productsBox = Hive.box('productPurchaseBox');
          List transaction = CartScreen.CART_ITEMS.map((e) => e.title).toList();
          transactionsBox.add({priceToPay, transaction});
          for(Meal meal in CartScreen.CART_ITEMS){
            var product = productsBox.get(meal.id);
            if(product != null){
              var updatedProduct = {'name': product['name'], 'counter': product['counter']+1};
              productsBox.put(meal.id, updatedProduct);
            }else{
              var newProduct = {'name': meal.title, 'counter': 1};
              productsBox.put(meal.id, newProduct);
            }

          }
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    ) : const SizedBox(height: 0,));
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
            const Center(
              child: Text("Checkout", style: TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold
              ),),
            ),
            const SizedBox(height: 12,),
            Column(
              children: items,
            ),
            const SizedBox(height: 12,),
            Center(child: Text(total, style: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold),)),
            const SizedBox(height: 20,),
            checkoutButton
          ],
        ),
      ),
      ),
    );
  }
}
