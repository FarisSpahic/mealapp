import 'package:flutter/material.dart';
import 'package:mealapp/themes/themes.dart';

class DarkModeSwitchWidget extends StatefulWidget {
  const DarkModeSwitchWidget({Key? key}) : super(key: key);

  @override
  State<DarkModeSwitchWidget> createState() => _DarkModeSwitchWidgetState();
}

class _DarkModeSwitchWidgetState extends State<DarkModeSwitchWidget> {

   final ThemePallete pallete = ThemePallete();

   @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.pinkAccent
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children:  [
            const Text("Dark mode", style: TextStyle(fontFamily: "Raleway", fontSize: 16),),
            const Spacer(),
            Switch(
                value: pallete.getIsDarkValue(),
                activeColor: Colors.pink,
                activeTrackColor: Colors.red,
                inactiveThumbColor: Colors.black87,
                inactiveTrackColor: Colors.black26,
                onChanged: (d){
                  pallete.switchTheme();
                  setState(() {
                });
                  debugPrint("value: $d"); })
          ],
        ),
      ),
    );
  }
}
