import 'package:flutter/material.dart';
import 'package:mealapp/router/router.dart';
import 'package:mealapp/themes/themes.dart';
void main() {
  runApp(const MealApp());
}

class MealApp extends StatefulWidget {
  const MealApp({Key? key}) : super(key: key);

  @override
  State<MealApp> createState() => _MealAppState();
}

class _MealAppState extends State<MealApp> {
  ThemePallete pallete = ThemePallete();
  @override
  void initState() {
    pallete.addListener(() {
      setState(() {});
    }
    );
    super.initState();
  }
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
