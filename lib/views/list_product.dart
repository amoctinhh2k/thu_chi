import 'package:app_thuchi/controllers/product_store.dart';
import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/widgets/product_add.dart';
import 'package:app_thuchi/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/products.dart';
import '../widgets/item_profile.dart';
import 'package:badges/badges.dart';

import 'list_search_date.dart';
import 'list_search_product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductStore ProductsStore = ProductStore();
  ValueNotifier<int> countCart = ValueNotifier(0);
  String date = DateTime.now().toString();
  late String _date, _name, _logo;
  late BankListDataModel _bankChoose;

  @override
  void dispose() {
    print('dispose');
    countCart.dispose();
    super.dispose();
  }
  void initState() {
    super.initState();
    _bankChoose = bankDataList[0];
    _name = _bankChoose.bank_name;
    _date = "${DateFormat('dd-MM-yyyy').format(
      DateTime.parse(
        date,
      ),
    )}";
  }

  void _onDropDownItemSelected(BankListDataModel newSelectedBank) {
    setState(() {
      _bankChoose = newSelectedBank;
    });
  }
  changeDate(String value) {
    _date = value;
    print("kkkk" + _date);
  }
  changeItem(BankListDataModel product) {
    _name = product.bank_name;
    _logo = product.bank_logo;
    print("logo");
  }

  @override
  Widget build(BuildContext context) {
    var visible = true;
    var rmicons = false;
    var isDialOpen = ValueNotifier<bool>(false);
    var speedDialDirection = SpeedDialDirection.down; // up, down

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () =>
            _onPressedHandler(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
          future: ProductsStore.stream(),
          builder: (context, AsyncSnapshot<Stream<List<Product>>> snapshot) {
            Stream<List<Product>>? _stream = snapshot.data;
            return StreamBuilder<List<Product>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Product>? _ProductsList = snapshot.data;
                  if (_ProductsList!.isNotEmpty) {
                    countCart.value = _ProductsList.length;
                  }
                  print('countCartcountCart ${countCart}');
                  if (_ProductsList.length == 0) {
                    TextTheme textTheme = Theme.of(context).textTheme;
                    return Scaffold(
                      appBar: AppBar(
                          title: const Text(' Danh sách chi tiêu'),
                          actions: <Widget>[
                            // IconButton(
                            //   icon: const Icon(Icons.search),
                            //   iconSize: 35,
                            //   onPressed: () {
                            //     _showSearch(context);
                            //   },
                            // ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                child: Badge(
                                  position:
                                      BadgePosition.topEnd(top: 3, end: 3),
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  animationType: BadgeAnimationType.slide,
                                  badgeColor: Colors.white,
                                  toAnimate: true,
                                  badgeContent: Text(
                                    '${countCart.value}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  child:
                                  IconButton(
                                    icon: const Icon(Icons.shopping_cart),
                                    iconSize: 35,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Hiện tại đã mua  ${countCart.value} vật phẩm!")));
                                    },
                                  ),
                                )),
                          ]),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () =>
                            // _showAdd(context),
                            _onPressedHandler(context),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      body: Center(
                        child: Text(
                          "Chưa có //",
                          style: textTheme.headline6,
                        ),
                      ),
                    );
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                          title: const Text(' Danh sách chi tiêu'),
                          actions: <Widget>[

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Expanded(
                                child: SpeedDial(
                                  icon: Icons.search,
                                  activeIcon: Icons.close,
                                  openCloseDial: isDialOpen,
                                  childPadding: const EdgeInsets.all(5),
                                  // visible: visible,
                                  direction: speedDialDirection,
                                  // view up , down
                                  tooltip: 'Mở menu ',
                                  // elevation: 8.0,
                                  children: [
                                    SpeedDialChild(
                                      child: !rmicons
                                          ? const Icon(Icons.search_off)
                                          : null,
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      label: 'Lọc theo vật phẩm',
                                      onTap: () {
                                        _showSearch(context);
                                      },
                                    ),
                                    SpeedDialChild(
                                      child: !rmicons
                                          ? const Icon(
                                              Icons.date_range_outlined)
                                          : null,
                                      backgroundColor: Colors.deepOrange,
                                      foregroundColor: Colors.white,
                                      label: 'Lọc theo thời gian',
                                      onTap: () {
                                        _showSearchDate(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Badge(
                                  position:
                                      BadgePosition.topEnd(top: 3, end: 3),
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  animationType: BadgeAnimationType.slide,
                                  badgeColor: Colors.white,
                                  toAnimate: true,
                                  badgeContent: Text(
                                    '${countCart.value}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  child:
                                  SpeedDial(
                                    icon: Icons.shopping_cart,
                                    // activeIcon: Icons.close,
                                    openCloseDial: isDialOpen,
                                    childPadding: const EdgeInsets.all(8),
                                    visible: visible,
                                    direction: speedDialDirection,
                                    // view up , down
                                    onPress: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                          content: Text(
                                              "Hiện tại đã muaqqqqqq  ${countCart.value} vật phẩm!")));
                                    },
                                  ),
                                  // IconButton(
                                  //   icon: const Icon(Icons.shopping_cart),
                                  //   iconSize: 35,
                                  //   onPressed: () {
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(SnackBar(
                                  //             content: Text(
                                  //                 "Hiện tại đã mua  ${countCart.value} vật phẩm!")));
                                  //   },
                                  // ),
                                )),
                          ]),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () =>
                            // _showAdd(context),
                            _onPressedHandler(context),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
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
                                    _onShowDetails(
                                        context, _ProductsList[index]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: ProductItem(
                                        product: _ProductsList[index]),
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            );
          }
          // },
          ),
    );
  }

  _onPressedHandler(BuildContext context) async {
    Product productAdd = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              // title: Text("Thêm mới"),
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        child: const Center(
                          child: Text('Thêm mới chi tiêu',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.black12)),
                      ),
                      const Center(
                        child: Text('-----------------',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey)),
                      ),
                      const SizedBox(height: 10.0),
                      ProductAdd(),
                    ]),
              ],
            ),
          ));
        });
    if (productAdd != null) {
      print("kkkkk" + productAdd.name + productAdd.toString());
      ProductsStore.save(productAdd);
    }
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

  _showSearch(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Tìm kiếm vật phẩm"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 1, top: 1, right: 1),
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 10, 20, 20),
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<BankListDataModel>(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontFamily: "verdana_regular",
                                    ),
                                    hint: Text(
                                      "Chọn vật phẩm",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontFamily: "verdana_regular",
                                      ),
                                    ),
                                    items: bankDataList.map<
                                            DropdownMenuItem<
                                                BankListDataModel>>(
                                        (BankListDataModel value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            new CircleAvatar(
                                              backgroundImage: new AssetImage(
                                                  value.bank_logo),
                                            ),
                                            // Icon(valueItem.bank_logo),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              value.bank_name,
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    isDense: true,
                                    onChanged:
                                        (BankListDataModel? newSelectedBank) {
                                      _onDropDownItemSelected(newSelectedBank!);
                                      changeItem(_bankChoose);
                                      (context as Element).markNeedsBuild();
                                      print("kkkkkkkkkk  -- " +
                                          _bankChoose.bank_logo);
                                    },
                                    value: _bankChoose,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ]),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey,
                          child: Text('Hủy'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text(
                            'Lọc',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Navigator.of(context, rootNavigator: true)
                            //     .pop('dialog');
                            print("kkkkkkkkk" + _name);
                            String kk = 'Quần áo';
                            Get.to(ProductListSearch(
                              name: _name,
                            ));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showSearchDate(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Tìm kiếm vật phẩm"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 10, 13, 10),
                      child: Icon(Icons.date_range, color: Colors.black54),
                    ),
                    Text("Ngày mua : ",
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor:Colors.black12,),
                        child: Text(
                          "${DateFormat('dd-MM-yyyy').format(
                            DateTime.parse(
                              date,
                            ),
                          )}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2022, 1, 1),
                              maxTime: DateTime.now(),
                              theme: DatePickerTheme(
                                // headerColor: Colors.orange,
                                // backgroundColor: Colors.blue,
                                  itemStyle: TextStyle(
                                    // color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle:
                                  TextStyle(
                                    // color: Colors.white,
                                      fontSize: 16)),
                              onChanged: (datevalue) {
                                date = '$datevalue';
                                changeDate("${DateFormat('dd-MM-yyyy').format(
                                  DateTime.parse(
                                    date,
                                  ),
                                )}");
                                (context as Element).markNeedsBuild(); // setState
                              }, onConfirm: (datevalue) {
                                date = '$datevalue';
                              }, currentTime: DateTime.now(), locale: LocaleType.vi);
                        },
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey,
                          child: Text('Hủy'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text(
                            'Lọc',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Navigator.of(context, rootNavigator: true)
                            //     .pop('dialog');
                            print("kkkkkkkkk" + _date);
                            String kk = 'Quần áo';
                            Get.to(ListSearchDate(
                              date: _date,
                            ));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
