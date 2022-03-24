import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// void main() {
//   runApp(MyApp());
// }


enum LegendShape { Circle, Rectangle }

class PieChartPage extends StatefulWidget {
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  final dataMap = <String, double>{
    "Đồ ăn": 5,
    "Quần áo": 3,
    "Đồ uống": 2,
    "Điện nước": 2,
    "Game": 5,
    "Du lịch": 3,

  };
  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
          ? 300
          : MediaQuery.of(context).size.width / 2.0,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "Chi Tiêu" : null,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
    );
    final settings = SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            SwitchListTile(
              value: _showGradientColors,
              title: Text("Đổi màu nổi"),
              onChanged: (val) {
                setState(() {
                  _showGradientColors = val;
                });
              },
            ),
            ListTile(
              title: Text("Khoảng cách"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _chartLegendSpacing,
                  disabledHint: Text("select chartType.ring"),
                  items: [
                    DropdownMenuItem(
                      child: Text("16"),
                      value: 16,
                    ),
                    DropdownMenuItem(
                      child: Text("32"),
                      value: 32,
                    ),
                    DropdownMenuItem(
                      child: Text("48"),
                      value: 48,
                    ),
                    DropdownMenuItem(
                      child: Text("64"),
                      value: 64,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartLegendSpacing = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Tùy chọn hiển thị chú thích'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SwitchListTile(
            //   value: _showLegendsInRow,
            //   title: Text("Hiển thị chú thích ngang"),
            //   onChanged: (val) {
            //     setState(() {
            //       _showLegendsInRow = val;
            //     });
            //   },
            // ),
            // SwitchListTile(
            //   value: _showLegends,
            //   title: Text("Hiển thị chú thích"),
            //   onChanged: (val) {
            //     setState(() {
            //       _showLegends = val;
            //     });
            //   },
            // ),
            // ListTile(
            //   title: Text("Đổi hình chú thích"),
            //   trailing: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //     child: DropdownButton<LegendShape>(
            //       value: _legendShape,
            //       items: [
            //         DropdownMenuItem(
            //           child: Text("Hình tròn"),
            //           value: LegendShape.Circle,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Hình vuông"),
            //           value: LegendShape.Rectangle,
            //         ),
            //       ],
            //       onChanged: (val) {
            //         setState(() {
            //           _legendShape = val;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            ListTile(
              title: Text("Lựa chọn"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendPosition>(
                  value: _legendPosition,
                  items: [
                    DropdownMenuItem(
                      child: Icon(Icons.subdirectory_arrow_left_outlined),
                      value: LegendPosition.left,
                    ),
                    DropdownMenuItem(
                      child: Icon(Icons.arrow_right_alt),
                      value: LegendPosition.right,
                    ),
                    DropdownMenuItem(
                      child: Icon(Icons.vertical_align_top),
                      value: LegendPosition.top,
                    ),
                    DropdownMenuItem(
                      child: Icon(Icons.vertical_align_bottom),
                      value: LegendPosition.bottom,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendPosition = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Lựa chọn vị trí'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SwitchListTile(
            //   value: _showChartValueBackground,
            //   title: Text("nền %"),
            //   onChanged: (val) {
            //     setState(() {
            //       _showChartValueBackground = val;
            //     });
            //   },
            // ),
            // SwitchListTile(
            //   value: _showChartValues,
            //   title: Text("showChartValues"),
            //   onChanged: (val) {
            //     setState(() {
            //       _showChartValues = val;
            //     });
            //   },
            // ),
            SwitchListTile(
              value: _showChartValuesInPercentage,
              title: Text("Đổi số lượng thành %"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesInPercentage = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesOutside,
              title: Text("Hiện % ra ngoài"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesOutside = val;
                });
              },
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Biểu đồ"),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                key = key + 1;
              });
            },
            child: Text("Reset".toUpperCase()),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: chart,
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: settings,
                )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: chart,
                    margin: EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                  ),
                  settings,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}