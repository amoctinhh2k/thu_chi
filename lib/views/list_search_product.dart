import 'package:app_thuchi/controllers/product_store.dart';
import 'package:app_thuchi/models/products.dart';

import 'package:app_thuchi/widgets/rounded_input_field.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:app_thuchi/widgets/thuchi_alert.dart';
import 'package:app_thuchi/widgets/product_add.dart';
import 'package:app_thuchi/widgets/product_item.dart';
import 'package:app_thuchi/widgets/product_update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/products.dart';
import '../widgets/item_profile.dart';
import 'package:badges/badges.dart';

class ProductListSearch extends StatefulWidget {
  const ProductListSearch({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  _ProductListSearchState createState() => _ProductListSearchState();
}

class _ProductListSearchState extends State<ProductListSearch> {
  final ProductStore ProductsStore = ProductStore();
  ValueNotifier<int> countCart= ValueNotifier(0);
@override
void dispose() {
  print('dispose');
  countCart.dispose();
    super.dispose();
  }

  @override
  void initState() {
  print('initState');
    super.initState();
    build(context);
  }



  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return StreamBuilder(
            builder: (context, snapshot) {
            return  FutureBuilder(
                future: ProductsStore.searchProducts(widget.name),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<Product>? _ProductsList = snapshot.data as List<Product>?;
                    if (_ProductsList!.isNotEmpty) {
                      print(""+_ProductsList.toString());
                      countCart.value = _ProductsList.length;
                    }
                    print('countCartcountCart ${countCart}');
                    if (_ProductsList.length == 0) {
                      TextTheme textTheme = Theme
                          .of(context)
                          .textTheme;
                      return Scaffold(
                          appBar: AppBar(title: Text('Danh sách ${widget.name} ',
                          style: TextStyle(fontSize: 20),),),
                        body: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "Chưa mua ${widget.name} !//",
                              style: textTheme.headline6,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Scaffold(
                        appBar: AppBar(title: Text('Danh sách ${widget.name} ',
                          style: TextStyle(fontSize: 20),
                        ),
                            actions: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5),
                                  child: Badge(
                                    position: BadgePosition.topEnd(top: 3, end: 3),
                                    animationDuration: Duration(milliseconds: 300),
                                    animationType: BadgeAnimationType.slide,
                                    badgeColor: Colors.white,
                                    toAnimate: true,
                                    badgeContent: Text(
                                      '${countCart.value}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme
                                              .of(context)
                                              .primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.shopping_cart),
                                      iconSize: 35,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Hiện tại tìm được  ${countCart
                                                        .value} vật phẩm ${widget.name}!")));
                                      },
                                    ),
                                  )
                              ),

                            ]),
                        floatingActionButtonLocation: FloatingActionButtonLocation
                            .centerFloat,
                        // floatingActionButton:
                        // FloatingActionButton(
                        //   backgroundColor: Colors.green,
                        //   onPressed: () =>
                        //   // _showAdd(context),
                        //   // _onPressedHandler(context),
                        //   child: const Icon(
                        //     Icons.add,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        body: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 75),
                            child: ListView.builder(
                              itemCount: _ProductsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  // onLongPress: () {
                                  //   _onShowDetails(context, _ProductsList[index]);
                                  // },
                                    onTap: () {
                                      _onShowDetails(context, _ProductsList[index]);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10),
                                      child:
                                      ProductItem(product: _ProductsList[index]),
                                    ));
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },

                // },
              );
            }
        );
      }
    );
  }

  _onShowDetails(BuildContext context, Product Products) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              // title: Text("Chi tiết"),
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                          child: Text("Chi tiết chi tiêu",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                      // SizedBox(height: 20.0),
                      const Center(
                        child: Text('-----------------',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey)),
                      ),
                      Center(
                        child: Container(
                          //this container is for circular image
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(Products.logo)),
                          ),
                        ),
                      ),
                      Detail_Profile(
                        lb: "Đồ mua",
                        txt: Products.name,
                        size: 15,
                      ),
                      Detail_Profile(
                        lb: "Giá tiền",
                        txt: Products.price + " vnđ",
                        size: 15,
                      ),
                      Detail_Profile(
                        lb: "Ghi chú",
                        txt: Products.note,
                        size: 15,
                      ),
                      Detail_Profile(
                        lb: "Ngày mua",
                        txt: Products.date,
                        size: 15,
                      ),
                      SizedBox(height: 20.0),

                    ]),
              ],
            ),
          ));
        });
  }

  }

