import 'dart:convert';

import 'package:app_thuchi/controllers/product_store.dart';
import 'package:app_thuchi/models/products.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

List _elements1 = [
  {'name': 'Quần áo', 'group': '24-03-2022'},
  {'name': 'Đồ ăn', 'group': '22-03-2022'},
  {'name': 'Quần áo', 'group': '23-03-2022'},
  {'name': 'Quần áo', 'group': '24-03-2022'},
  {'name': 'Quần áo', 'group': '23-03-2022'},
  {'name': 'Đồ uống', 'group': '24-03-2022'},
];
var list_2;

class MyList extends StatelessWidget {

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
        body:

        FutureBuilder(
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
              list_2 = List<dynamic>.from(_ProductsList);
              print("pppppppp" + _elements1.toString());
              print("llllllllll" + list_2.toString());
              print('countCartcountCart ${_ProductsList.runtimeType}');
              if (_ProductsList.length == 0) {
                TextTheme textTheme = Theme
                    .of(context)
                    .textTheme;
                return Scaffold(
                  body: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "Chưa chi tiêu !//",
                        style: textTheme.headline6,
                      ),
                    ),
                  ),
                );
              } else {
                return
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 75),
                      child: GroupedListView<dynamic, String>(
                        groupBy: (element) => element['date'],
                        // elements: list_2,
                        elements: _elements1,
                        sort: true,
                        groupSeparatorBuilder: (String value) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                    _ProductsList[1].toString() + "" +
                                        value,
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),

                        order: GroupedListOrder.ASC,
                        itemBuilder: (c, element) {
                          return Card(
                            elevation: 0.5,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              child: ListTile(
                                contentPadding:
                                EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Icon(Icons.date_range_outlined),
                                title: Text(element['name']),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                          );
                        },
                      ),
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