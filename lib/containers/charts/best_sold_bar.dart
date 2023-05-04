import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mealapp/main.dart';


class BestSoldProductBarChartView extends StatefulWidget {
  const BestSoldProductBarChartView({Key? key}) : super(key: key);

  @override
  State<BestSoldProductBarChartView> createState() => _BestSoldProductBarChartViewState();
}

class _BestSoldProductBarChartViewState extends State<BestSoldProductBarChartView> {
  var productsBox;
  @override
  void initState() {
    // TODO: implement initState
    productsBox = Hive.box("productPurchaseBox");
    super.initState();
  }

  double getPercentage(int value, int size){
    // 1000 because of the adequate sizing of chart bars
    return (value / size) * 1000;
  }



  @override
  Widget build(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  dynamic item1, item2, item3;
  List<dynamic> items = productsBox.values.toList();
  if(items.length > 2){
    items.sort((a, b) => b['counter'].compareTo(a['counter']));

    dynamic numberOfSales = 0;
    items.forEach((element) { numberOfSales += element['counter'];});

    // title, size relative to sale
     item1 = {'name' : items[0]['name'], 'size': getPercentage(items[0]['counter'], numberOfSales).round()};
     item2 = {'name' : items[1]['name'], 'size': getPercentage(items[1]['counter'], numberOfSales).round()};
     item3 = {'name' : items[2]['name'], 'size': getPercentage(items[2]['counter'], numberOfSales).round()};


  }
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints pconstraints){

      if(items.length < 2) {
        return Text("no data sryy");
      } else {
        return Container(
          height: height/5,
          width: width/1.1,
          decoration:  BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: Text("The most sold products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Raleway'))),
                const SizedBox(height: 15,),
                Expanded(
                  child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints){
                        debugPrint(pconstraints.maxHeight.toString());
                        debugPrint(constraints.maxHeight.toString());

                        return Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight/3,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                barChart(item1, constraints.maxHeight),
                                Spacer(),
                                barChart(item2, constraints.maxHeight),
                                Spacer(),
                                barChart(item3, constraints.maxHeight)


                              ],
                            ),
                          )

                        );
                      }
                  ),
                )
              ],
            ),
          )
      );
      }
    },
  );


  }


}

Widget barChart(dynamic item, double height){
  return Container(
    height: height,
    child: Column(
      children: [
        Container(
          height: item['size'].toDouble()/7,
          width: 25,
          color: Colors.pink,
        ),
        const SizedBox(height: 5,),
        Wrap(
direction:  Axis.vertical,
          children: [
            Text(item['name'], style: TextStyle(fontFamily: 'Raleway', fontSize: 8),),
       ]
  ), Text("${item['size']/10}%", style: TextStyle(fontFamily: 'Raleway', fontSize: 12),)
      ],
    ),
  );
}
