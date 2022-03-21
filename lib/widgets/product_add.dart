import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/widgets/thuchi_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'item_profile.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'rounded_input_field.dart';

class ProductAdd extends StatefulWidget {
  @override
  ProductAddState createState() {
    return new ProductAddState();
  }
}

class ProductAddState extends State<ProductAdd> {
  // String dropdownValue = 'Nhân sự';
  String date = DateTime.now().toString();
  late String _date;

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  bool _validate = false;
  bool _validate1 = false;

  changeNm(String value) {
    _date = value;
    print("kkkk" + _date);
  }

  _onSubmittedHandler(BuildContext context) {
    String name = _namecontroller.text.trim();
    String price = _pricecontroller.text.trim();
    _date = "${DateFormat('dd-MM-yyyy').format(
      DateTime.parse(
        date,
      ),
    )}";

    if (name.length == 0 || price.length == 0) {
      print("pppppppppp" + _date);
      Navigator.of(context).pop();
    } else {
      print("yyyyyyyy" + _date);
      Product product = Product(name: name, price: price, date: _date);
      FrappeAlert.successAlert(
        title: "Thông báo",
        subtitle: 'Thêm mới thành công !',
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
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(100),
            // FilteringTextInputFormatter.digitsOnly
          ],
          cursorColor: Colors.white,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          controller: _namecontroller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.send,
          // onSubmitted: (_) => _onSubmittedHandler(context),
          decoration: InputDecoration(
            labelText: "Vật phẩm",
            prefixIcon: Icon(Icons.assignment),
            errorText: _validate ? 'Chưa nhập vật phẩm !' : null,
          ),
        ),

        Flexible(
          child: TextField(
            // enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
            controller: _pricecontroller,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.send,
            maxLines: null,
            // inputFormatters: <TextInputFormatter>[
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Giá tiền",
              prefixIcon: Icon(Icons.monetization_on),
              errorText: _validate1 ? 'Chưa nhập giá tiền !' : null,
            ),
          ),
        ),
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
            child: FlatButton(
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
          )
        ]),
        RaisedButton(
          color: Colors.blue,
          child: const Text(
            'Lưu',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              _namecontroller.text.isEmpty
                  ? _validate = true
                  : _validate = false;
              _pricecontroller.text.isEmpty
                  ? _validate1 = true
                  : _validate1 = false;
            });
            // FocusScope.of(context).requestFocus(
            //   FocusNode(),
            // ); // ẩn bàn phím
            if (!_validate && !_validate1) {
              _onSubmittedHandler(context);
            }
            // Navigator.of(context, rootNavigator: true)
            //     .pop('dialog');
          },
        ),
      ],
    );
  }
}
