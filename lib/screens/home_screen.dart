import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mealapp/containers/date_widget.dart';
import 'package:mealapp/containers/food_gallery.dart';
import 'package:mealapp/router/router.dart';
import 'package:mealapp/themes/themes.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: _appBar(context),
          body: Column(
            children: <Widget>[
              Container(
              margin: const EdgeInsets.all(12),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Popular", style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold
                  )
                  ),
                ),
              ),
              const FoodGallery(),
              const DateWidget()
            ],
          ),
      ),
    );
  }

}

AppBar _appBar(BuildContext context) {
  final mySystemTheme= SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.black87, statusBarColor: Colors.pinkAccent);
  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  return AppBar(
    title: const Text("Mealz"),
    backgroundColor: Colors.black,
    centerTitle: true,
    titleTextStyle: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 24
    ),

    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: GestureDetector(
          child: const Icon(Icons.shopping_cart),
          onTap: () {
            context.push("/cart");
          },
        ),
      ),

    ],

  );
}