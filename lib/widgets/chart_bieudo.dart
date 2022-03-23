import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class ChartBieuDo extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartBieuDo({Key? key}) : super(key: key);

  @override
  _ChartBieuDoState createState() => _ChartBieuDoState();
}

class _ChartBieuDoState extends State<ChartBieuDo> {

  final List<ChartData> chartData = [
    ChartData('A', 25),
    ChartData('B', 38),
    ChartData('C', 34),
    ChartData('D', 52)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Biểu đồ"),),
        body: Column(
          children: [
            // Container(
            //     child: SfCircularChart(series: <CircularSeries>[
            //   PieSeries<ChartData, String>(
            //       dataSource: chartData,
            //       xValueMapper: (ChartData data, _) => data.name,
            //       yValueMapper: (ChartData data, _) => data.price,
            //       explode: true,
            //       // All the segments will be exploded
            //       explodeAll: true)
            // ])),

            Container(
                child: SfCircularChart(
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Container(
                              child: PhysicalModel(
                                  child:
                                  Container(
                                      child: SfCircularChart(series: <CircularSeries>[
                                        PieSeries<ChartData, String>(
                                            dataSource: chartData,
                                            xValueMapper: (ChartData data, _) => data.name,
                                            yValueMapper: (ChartData data, _) => data.price,
                                            explode: true,
                                            explodeAll: true)
                                      ])),

                                  // shape: BoxShape.circle,
                                  // elevation: 10,
                                  // shadowColor: Colors.black,
                                  color: const Color.fromRGBO(230, 230, 230, 1)
                              ))),
                      // CircularChartAnnotation(
                      //     widget: Container(
                      //         child: const Text('62%',
                      //             style: TextStyle(
                      //                 // color: Color.fromRGBO(0, 0, 0, 0.5),
                      //                 fontSize: 25))))
                    ],

                    series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.name,
                          yValueMapper: (ChartData data, _) => data.price,
                          // Radius of doughnut
                          radius: '50%'
                      )
                    ]
                )
            )
          ],
        ));
  }
}

class ChartData {
  ChartData(this.name, this.price, [this.color]);

  final String name;
  final double price;
  final Color? color;
}
