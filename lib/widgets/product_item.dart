import 'package:app_thuchi/controllers/product_store.dart';
import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/widgets/product_update.dart';
import 'package:app_thuchi/widgets/thuchi_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final ProductStore taskStore = ProductStore();

  ProductItem({required this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final ProductStore ProductsStore = ProductStore();


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child:
                      // CarouselWithIndicatorDemo(),
                      Container(
                        //this container is for circular image
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(widget.product.logo)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 3, 3, 3),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.product.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("*",style: TextStyle(color: Colors.grey),),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '( ${widget.product.note} )',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.deepOrangeAccent
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 3, 3, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.product.price
                                      + " đ",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                          ]),
                    ),
                    Expanded(
                      flex: 2,
                      child:
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                           ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                  onTap: () {
                                    _onTapEdit(context, widget.product);
                                        },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 25,
                                  )),
                            ),
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                  onTap: () {
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
                                          ProductsStore.delete(widget.product);
                                          FrappeAlert.errorAlert(
                                            title: "Thông báo",
                                            subtitle: 'Xóa thành công !',
                                            context: context,
                                          );
                                          // Navigator.pop(context);
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
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                    size: 25,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ]),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(widget.product.date,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.black45)),
                  )),
            ],
          )),
    );
  }



  _onTapEdit(BuildContext context, Product product) async {
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
