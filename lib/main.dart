import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mealapp/router/router.dart';
import 'package:mealapp/themes/themes.dart';


void main() async {
  await Hive.initFlutter();
  var productsBox = await Hive.openBox("productPurchaseBox");
  await productsBox.close();
  var transactionsBox = await Hive.openBox("transactionsBox");
  await Hive.openBox("productPurchaseBox");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MealApp());

}

class MealApp extends StatefulWidget {
  const MealApp({Key? key}) : super(key: key);

  @override
  State<MealApp> createState() => _MealAppState();
}

class _MealAppState extends State<MealApp> {
  ThemePallete pallete = ThemePallete();


  final darkNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child){
        return MaterialApp.router(
          routerConfig: router,
          title: 'Mealz',
          debugShowCheckedModeBanner: false,
         themeMode: pallete.currentTheme(),
         theme: pallete.getIsDarkValue() ? ThemeData.dark() : ThemeData.light(),
        // darkTheme: darkThemeConfig(),
        );
      }
      );
  }

}
