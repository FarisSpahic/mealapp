import 'package:flutter/material.dart';
import 'package:mealapp/containers/setting_props/dark_mode.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children:  [
            const Text("Settings", style: TextStyle(fontSize: 22, fontFamily: "Raleway", fontWeight: FontWeight.bold),),
            SingleChildScrollView(
              child: Column(
                children: const [
                  DarkModeSwitchWidget()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
