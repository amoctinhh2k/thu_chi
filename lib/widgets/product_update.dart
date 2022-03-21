import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/widgets/thuchi_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'item_profile.dart';

class ProductUpdate extends StatelessWidget {
  // late final String date1;
  String date = "";
  String _date = "";
  final Product product;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();

  ProductUpdate({required this.product}) {
    _namecontroller.text = product.name;
    _pricecontroller.text = product.price;
    date = product.date;
    _date = date;
    print("pppppppppppppp" + date);
  }

  changeNm(String value) {
    _date = value;
    print("kkkk" + _date);
  }

  _onSubmittedHandler(BuildContext context) {
    String name = _namecontroller.text.trim();
    String price = _pricecontroller.text.trim();
    if (name == product.name &&
        price == product.price &&
        _date == product.date) {
      Navigator.of(context).pop(product);
    } else {
      product.name = name;
      product.price = price;
      product.date = _date;
      FrappeAlert.warnAlert(
        title: "Thông báo",
        subtitle: 'Cập nhật thành công !',
        context: context,
      );
      Navigator.of(context).pop(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: <Widget>[
        TextField(
          // autocorrect: true,
          // autofocus: true,
          enableSuggestions: true,
          textCapitalization: TextCapitalization.sentences,
          controller: _namecontroller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.send,
          maxLines: null,
          // onSubmitted: (_) => _onSubmittedHandler(context),
          decoration: InputDecoration(
              labelText: "Vật phẩm", prefixIcon: Icon(Icons.assignment)),
        ),
        TextField(
          // autocorrect: true,
          // autofocus: true,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          enableSuggestions: true,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          controller: _pricecontroller,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.send,
          decoration: const InputDecoration(
              labelText: "Giá tiền", prefixIcon: Icon(Icons.money)),
        ),
        Row(
          children: <Widget>[
            const SizedBox(
              width: 10,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(3, 10, 13, 10),
              child: Icon(Icons.date_range, color: Colors.black54),
            ),
            const Text("Ngày mua : ",
                style: TextStyle(fontSize: 16, color: Colors.black54)),
            Padding(
              padding: const EdgeInsets.all(1),
              child: FlatButton(
                child: Text(
                  _date.toString(),
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
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (datevalue) {
                    date = '$datevalue';
                    changeNm("${DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(
                        date,
                      ),
                    )}");
                    (context as Element).markNeedsBuild(); // setState
                  }, onConfirm: (datevalue) {
                    date = '$datevalue';
                  }, currentTime: DateTime.now(), locale: LocaleType.vi);
                },
                color: Colors.black12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Lưu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(
                FocusNode(),
              );
              Get.defaultDialog(
                  title: "Thông báo!",
                  // middleText: "Thông báo!",
                  backgroundColor: Colors.white,
                  titleStyle: TextStyle(color: Colors.white),
                  middleTextStyle: TextStyle(color: Colors.green),
                  onCancel: () {
                    // Navigator.of(context, rootNavigator: true)
                    //     .pop('dialog');
                    // Navigator.pop(context);
                  },
                  onConfirm: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    _onSubmittedHandler(context);
                    // Navigator.pop(context);
                  },
                  textConfirm: "Ok",
                  textCancel: "Không",
                  cancelTextColor: Colors.grey,
                  confirmTextColor: Colors.green,
                  buttonColor: Colors.white,
                  barrierDismissible: false,
                  radius: 50,
                  content: Column(
                    children: [
                      Container(child: Text("Bạn có chắc chắn : ")),
                      Container(child: Text("muốn cập nhật ? ")),
                    ],
                  )); // ẩn bàn phím
              // _onSubmittedHandler(context);
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
              // taskStore.update(task);
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          ),
        ]),
      ],
    );
  }
}
