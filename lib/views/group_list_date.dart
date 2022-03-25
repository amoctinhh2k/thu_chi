import 'dart:convert';

import 'package:app_thuchi/controllers/product_store.dart';
import 'package:app_thuchi/models/products.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'list_product.dart';

List _elements1 = [
  {'name': 'Quần áo', 'date': '24-03-2022'},
  {'name': 'Đồ ăn', 'date': '22-03-2022'},
  {'name': 'Quần áo', 'date': '23-03-2022'},
  {'name': 'Quần áo', 'date': '24-03-2022'},
  {'name': 'Quần áo', 'date': '23-03-2022'},
  {'name': 'Đồ uống', 'date': '24-03-2022'},
];
var list;
var _elements;

class MyList extends StatefulWidget {
  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final ProductStore ProductsStore = ProductStore();

  // List<Product> _elements = ProductsStore.getAllProducts() as List<Product>;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: ProductsStore.getAllProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Product>? _ProductsList = snapshot.data as List<Product>?;
              if (_ProductsList!.isNotEmpty) {
                print("llllllllll" + _ProductsList.toString());
              }
              print('countCartcountCart ${_ProductsList.runtimeType}');
              if (_ProductsList.length == 0) {
                TextTheme textTheme = Theme.of(context).textTheme;
                return Scaffold(
                  body: Container(
                    color: Colors.white,
                    child: Center(
                      child: Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Không có !//",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.deepOrangeAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Thêm mới chi tiêu ngay:",
                              style: TextStyle(
                                  fontSize: 13, fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SpeedDial(
                              icon: Icons.add,
                              backgroundColor: Colors.green,
                              activeIcon: Icons.close,
                              // openCloseDial: isDialOpen,
                              childPadding: const EdgeInsets.all(5),
                              // visible: visible,
                              tooltip: 'Mở menu ',
                              onPress: () {
                                Get.to(ProductListScreen());
                              },
                              elevation: 8.0,
                              children: [],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                const jsonArray = '''
  [{"name": "foo", "value": 1, "status": true},
   {"name": "bar", "value": 2, "status": false}]
''';
                final List dataList = jsonDecode(jsonArray);
                print(dataList[0]); // {text: foo, value: 1, status: true}
                print(dataList[1]); // {text: bar, value: 2, status: false}

                final item = dataList[0];
                print(item['name']); // foo
                print(item['value']); // 1

                list = _ProductsList.toString();
                print("pppppppp" + _elements1.toString());
                print("llllllllll" + list.toString());
                print("yyyyyyyyy" + dataList.toString());
                print("qqqqqqqqq + ${dataList.runtimeType}");
                _elements = jsonDecode(list);
                print("ggggggggggggg " + _elements.toString());
                print('countCartcountCart ${_elements.runtimeType}');
                return SafeArea(
                  child: GroupedListView<dynamic, String>(
                    groupBy: (element) => element['date'],
                    elements: _elements,
                    // elements: _elements1,
                    sort: true,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8,8),
                      child: Row(
                        children: [
                          Icon(Icons.date_range_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Chi tiêu : --",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    order: GroupedListOrder.DESC,
                    itemBuilder: (c, element) {
                      return Card(
                        elevation: 0.5,
                        // margin: new EdgeInsets.symmetric(
                        //     horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child:
                                      // CarouselWithIndicatorDemo(),
                                      Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      image: DecorationImage(
                                          // fit: BoxFit.fill,
                                          image: AssetImage(element['logo'])),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 3, 0, 3),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  element['name'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "*",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        3, 3, 3, 3),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "("
                                                    '${element['note']}'
                                                    ")",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors
                                                            .deepOrangeAccent),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 3, 3, 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              element['price'] + " đ",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          // ListTile(
                          //   contentPadding:
                          //   EdgeInsets.symmetric(
                          //       horizontal: 20.0, vertical: 10.0),
                          //   // leading: Icon(Icons.date_range_outlined),
                          //   title: Text(element['name']),
                          //   trailing: Icon(Icons.arrow_forward),
                          // ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          },

          // },
        ),
      ),
    );
  }
}
