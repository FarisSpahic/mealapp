import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealapp/models/calendar_helper.dart';


class DateWidget extends StatelessWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            //review
            ...dateSubwidget(),
            const Spacer(),
            GestureDetector(
              onTap: (){
                GoRouter.of(context).push("/calendar");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Open Calendar", style: TextStyle(color: Colors.pink, fontFamily: "Poppins"),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> dateSubwidget(){
    return [
      const Text("Date  ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: "Poppins"),),
      const SizedBox(width: 5,),
      Text(Calendar().getDate(), style: const TextStyle(fontFamily: "Raleway", fontSize: 18),),
    ];
  }
}
