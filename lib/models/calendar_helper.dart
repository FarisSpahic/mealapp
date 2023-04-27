class Calendar{

  DateTime getLocalDateTime(){
    return DateTime.now().toLocal();
  }
  String getDate(){
    return "${getLocalDateTime().day}/${getLocalDateTime().month}/${getLocalDateTime().year}";
  }
  String getWeekdayName(){
    switch(getLocalDateTime().weekday){
      case 1:
        return "Monday";
        break;
      case 2:
        return "Tuesday";
        break;
      case 3:
        return "Tuesday";
        break;
      case 4:
        return "Wednesday";
        break;
      case 5:
        return "Friday";
        break;
      case 6:
        return "Saturday";
        break;
      case 7:
        return "Sunday";
        break;
    }
    return "";
  }

  List<List> getCalendar(){
    DateTime date = DateTime.now().toLocal();
    int days = DateTime(date.year, date.month + 1, 0).day;
    List weekList = [];
    List<List> monthList = [];
    // get num of days in month

    int i = 1;

    int currentDayweek = DateTime(date.year, date.month, 1).weekday;
    if(currentDayweek != 1){
      weekList = List.filled(currentDayweek - 1, null, growable: true);
    }

    while (i <= days) {
      int weekday = DateTime(date.year, date.month, i).weekday;
      weekList.add(i);
      if(weekday == 7 || i == days){
        monthList.add(weekList);
        weekList = [];
      }
      i++;
    }


    return monthList;
  }


}