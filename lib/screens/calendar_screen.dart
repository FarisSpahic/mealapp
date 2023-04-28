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
              Center(
                  child: Text(
                "Calendar",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10,
              ),
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
  TextStyle iconStyle =
      const TextStyle(fontSize: 22, fontFamily: "Raleway", color: Colors.black);

  //review
  List calendarDayTagFormatter(String day) {
    Widget textWidget = Text(day, style: iconStyle);

    if (day == "Mon") {
      return [const Spacer(), textWidget , const Spacer()];
    } else {
      return [ textWidget, const Spacer()];
    }
  }
  
  //review
  List calendarIcons(dynamic day) {
    BoxDecoration decoration = const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
    );
    dynamic text;
    if(day == null) {
      text = "X";
    } else {
      text = day;
    }
      return [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                text.toString(),
                style: iconStyle,
              ),
            ),
          ),
        ),
        const Spacer()
      ];
    
  }

  @override
  Widget build(BuildContext context) {

    calendarDaysWidgets.add(Row(
      children: [
        ...calendarDayTagFormatter("Mon"),
        ...calendarDayTagFormatter("Tue"),
        ...calendarDayTagFormatter("Wed"),
        ...calendarDayTagFormatter("Thu"),
        ...calendarDayTagFormatter("Fri"),
        ...calendarDayTagFormatter("Sat"),
        ...calendarDayTagFormatter("Sun")

        // const Spacer(),
        // Text("Mon", style: iconStyle),
        // const  Spacer(),
        // Text("Tue", style: iconStyle),
        // const  Spacer(),
        // Text("Wed", style: iconStyle),
        // const Spacer(),
        // Text("Thu", style: iconStyle),
        // const Spacer(),
        // Text("Fri", style: iconStyle),
        // const Spacer(),
        // Text("Sat", style: iconStyle),
        // const Spacer(),
        // Text("Sun", style: iconStyle),
        // const  Spacer(),
      ],
    ));

    for (List week in calendarDays) {
      List<Widget> icons = [];

      BoxDecoration decoration = const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      );

      for (int i = 0; i < week.length; i++) {
        //review
          calendarIcons(week[i]).forEach((element) { icons.add(element); });
      }
      calendarDaysWidgets.add(Row(
        children: icons,
      ));
    }
    //@build return
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            children: [
              //review
             calendarTitle(),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: calendarDaysWidgets,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );

  }

  Widget calendarTitle(){
   return  Center(
     child: Text(
       Calendar().getWeekdayName(),
       style: const TextStyle(
           color: Colors.black,
           fontWeight: FontWeight.bold,
           fontFamily: "Poppins",
           fontSize: 20),
     ),
   );
  }
}
