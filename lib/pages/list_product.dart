import 'package:app_thuchi/controllers/product_store.dart';
import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/pages/home.dart';
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

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductStore ProductsStore = ProductStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' Danh sách chi tiêu'),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Badge(
            position: BadgePosition.topEnd(top: 3, end: 3),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            badgeColor: Colors.white,
            toAnimate: true,
            badgeContent: Text(
              '0',
              style: TextStyle(
                  fontSize: 8,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            child: IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Không có thông báo nào!")));
              },
            ),
          ),
        ),
      ]),
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
        child: FutureBuilder(
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
                    if (_ProductsList?.length == 0) {
                      TextTheme textTheme = Theme.of(context).textTheme;
                      return Center(
                        child: Text(
                          "Chưa có //",
                          style: textTheme.headline6,
                        ),
                      );
                    } else {
                      // setState(() {
                      //   sl == _ProductsList?.length;
                      // });
                      return ListView.builder(
                        itemCount: _ProductsList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          // setState(() {
                          //   sl +=sl;
                          // });
                          return InkWell(
                              onLongPress: () {
                                _onShowDetails(context, _ProductsList![index]);
                              },
                              onTap: () {
                                ProductsStore.findAll();

                                print(";;;;;;;;;;;;;;");
                                _onLongPressHandler(
                                    context, _ProductsList![index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child:
                                    ProductItem(product: _ProductsList![index]),
                              ));
                        },
                      );
                    }
                  }
                },
              );
            }
            // },

            ),
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
                      SizedBox(height: 20.0),
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
                        lb: "Ngày mua",
                        txt: Products.date,
                        size: 15,
                      ),
                      SizedBox(height: 20.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text('Xoá'),
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "Thông báo!",
                                    // middleText: "Thông báo!",
                                    backgroundColor: Colors.white,
                                    titleStyle: TextStyle(color: Colors.red),
                                    middleTextStyle:
                                        TextStyle(color: Colors.white),
                                    onCancel: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                    onConfirm: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                      ProductsStore.delete(Products);
                                      FrappeAlert.errorAlert(
                                        title: "Thông báo",
                                        subtitle: 'Xóa thành công !',
                                        context: context,
                                      );
                                      Navigator.pop(context);
                                    },
                                    textConfirm: "Ok",
                                    textCancel: "Không",
                                    cancelTextColor: Colors.black54,
                                    confirmTextColor: Colors.red,
                                    buttonColor: Colors.black12,
                                    barrierDismissible: false,
                                    radius: 50,
                                    content: Column(
                                      children: [
                                        Container(
                                            child: Text("Bạn có chắc chắn : ")),
                                        Container(child: Text("muốn xóa ? ")),
                                      ],
                                    ));
                                // ProductsStore.delete(Products);
                                // Navigator.of(context, rootNavigator: true)
                                //     .pop('dialog');
                              },
                            ),
                            SizedBox(width: 20.0),
                            RaisedButton(
                              color: Colors.grey,
                              child: Text('Hủy'),
                              onPressed: () {
                                FocusScope.of(context).requestFocus(
                                  FocusNode(),
                                ); // ẩn bàn phím
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                            ),
                          ])
                    ]),
              ],
            ),
          ));
        });
  }

  _onLongPressHandler(BuildContext context, Product product) async {
    Product productEdit = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              // title: Text("Cập nhật"),
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        child: const Center(
                          child: Text('Cập nhật chi tiêu',
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
                      ProductUpdate(product: product),
                    ]),
              ],
            ),
          ));
        });
    if (productEdit != null) {
      print("upppp" + productEdit.name + productEdit.toString());
      ProductsStore.update(productEdit);
      // ProductsStore.delete(ProductsEdited);
    }
  }
}
