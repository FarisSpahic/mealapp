import 'package:flutter/material.dart';
import 'package:mealapp/models/calendar_helper.dart';
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Center(child: Text("Calendar", style: TextStyle(fontSize: 24, fontFamily: "Raleway", fontWeight: FontWeight.bold),)),
              SizedBox(height: 10,),
              Center(child: CalendarView()),

            ],
          ),
        ),
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  List<List> calendarDays = Calendar().getCalendar();
  List<Row> calendarDaysWidgets = [];



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double width = size.width; double height = size.height;
    TextStyle iconStyle = const TextStyle(fontSize: 22, fontFamily: "Raleway", color: Colors.black);

    calendarDaysWidgets.add(Row(
      children:  [
        const Spacer(),
        Text("Mon", style: iconStyle),
        const  Spacer(),
        Text("Tue", style: iconStyle),
        const  Spacer(),
        Text("Wed", style: iconStyle),
        const Spacer(),
        Text("Thu", style: iconStyle),
        const Spacer(),
        Text("Fri", style: iconStyle),
        const Spacer(),
        Text("Sat", style: iconStyle),
        const Spacer(),
        Text("Sun", style: iconStyle),
        const  Spacer(),
      ],
    ));
    for(List week in calendarDays){
      List<Widget> icons = [];
      BoxDecoration decoration = const BoxDecoration(shape : BoxShape.circle, color: Colors.white,);
      // Boze, pomozi.
      for(int i = 0; i < week.length; i++){
        if(week[i] != null){
          icons.add(const Spacer());
          icons.add(Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(decoration: decoration,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(week[i].toString(), style: iconStyle,),
            ), ),
          ));
          icons.add(const Spacer());
        }else{
          icons.add(const Spacer());
          icons.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(decoration: decoration,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("X", style: iconStyle,),
            ),),
          ));
          icons.add(const Spacer());
        }
      }
      calendarDaysWidgets.add(Row(children: icons,));
    }


    return  Padding(
        padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Text(Calendar().getWeekdayName(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: 20),),
              ),
            const SizedBox(height: 20,),
            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,children: calendarDaysWidgets, ),
              const SizedBox(height: 20,),

            ],

          ),
        ),
      ),
    );
  }
}
