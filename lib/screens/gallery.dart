import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';

class GalleryScreen extends StatefulWidget {
   const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int dropdownButtonValue = 1;
  List<String> images = DUMMY_MEALS.map((image) => image.imageUrl).toList();
  Widget displayWidget = ColumnGalleryWidget();
  @override
  Widget build(BuildContext context) {
    if(dropdownButtonValue == 1) {
      displayWidget = ColumnGalleryWidget();
    } else if(dropdownButtonValue == 2) {
      displayWidget = RowGalleryWidget();
    }
    else if(dropdownButtonValue == 3){
      displayWidget = TBTGalleryWidget();
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // 1 button to choose 3x3, row or column view
        // array of images
        // fill out
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButton(
                  underline: const SizedBox(),
                  icon: const SizedBox(),
                  alignment: Alignment.center,
                  value: 1,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: Colors.pinkAccent,
                  items: const [
                    DropdownMenuItem(value: 1,child: Text("Column"),),
                    DropdownMenuItem(value: 2,child: Text("Row"),),
                    DropdownMenuItem(value: 3,child: Text("3x3"),)
                  ],
                  onChanged: (val){
                    setState(() {
                      dropdownButtonValue = val!;
                    });
              }),
              const SizedBox(height: 8,),
            // widget(val) => logika za display itema
            //column => if row layout only one child
            // if column array of images
            // if 3x3
            displayWidget
            ],
          ),
        ),

      );
  }
}
class ColumnGalleryWidget extends StatelessWidget {
  ColumnGalleryWidget({Key? key}) : super(key: key);

  final List<String> images = DUMMY_MEALS.map((image) => image.imageUrl).toList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Widget> items = images.map((e) => Image.network(e, width: size.width, height: size.height/2, fit: BoxFit.contain,)).toList();
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: items,
        ),
      ),
    );
  }
}
class RowGalleryWidget extends StatelessWidget {
  RowGalleryWidget({Key? key}) : super(key: key);
  final List<String> images = DUMMY_MEALS.map((image) => image.imageUrl).toList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Widget> items = images.map((e) => Container(margin: const EdgeInsets.only(right: 10),child: Image.network(e, width: size.width/1.7, height: size.height/4, fit: BoxFit.fill,))).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
    );
  }
}

class TBTGalleryWidget extends StatelessWidget {
  TBTGalleryWidget({Key? key}) : super(key: key);
  final List<String> images = DUMMY_MEALS.map((image) => image.imageUrl).toList();
  // list of rows with each having 3 imgs
  List<Row> getImageRowList(List<Widget> images){
    List<Row> rows = [];
    List<Widget> tempArray = [];
    for(Widget img in images){
      tempArray.add(img);

      if(tempArray.length == 3){
        rows.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,children: tempArray,));
        tempArray = [];
      }
    }
    return rows;
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final List<Widget> items = images.map((e) => Image.network(e, width: size.width/3.8, height: size.height/3.8,  fit: BoxFit.fill,)).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: getImageRowList(items),
      ),
    );
  }
}
