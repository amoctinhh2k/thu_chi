import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/widgets/thuchi_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ProductUpdate extends StatefulWidget {
  final Product product;

  ProductUpdate({required this.product}) {}

  @override
  ProductUpdateState createState() {
    return new ProductUpdateState();
  }
}

class ProductUpdateState extends State<ProductUpdate> {
  late BankListDataModel _bankChoose;
  String? date;
  String? _date, _name, _logo;
  TextEditingController _noteController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  void initState() {
    super.initState();
    // _bankChoose = BankListDataModel('', '');
    print("llllllllll" + widget.product.logo);
    _noteController.text = widget.product.note;
    _priceController.text = widget.product.price;
    date = widget.product.date;
    _date = date;
    _name = widget.product.name;
    _logo = widget.product.logo;
    // _bankChoose = bankDataList[0];
    _bankChoose = BankListDataModel(widget.product.name, widget.product.logo);
    Future.delayed(700.milliseconds, () {
      setState(() {
        _bankChoose = BankListDataModel(widget.product.name, widget.product.logo);
      });
    });
  }

  void _onDropDownItemSelected(BankListDataModel newSelectedBank) {
    setState(() {
      _bankChoose = newSelectedBank;
    });
  }

  changeDate(String value) {
    _date = value;
    print("kkkk" + _date!);
  }

  changeProduct(BankListDataModel product) {
    _name = product.bank_name;
    _logo = product.bank_logo;
    print("logo");
  }

  _onSubmittedHandler(BuildContext context) {
    String note = _noteController.text.trim();
    String price = _priceController.text.trim();

    if (_name == widget.product.name &&
        price == widget.product.price &&
        _date == widget.product.date &&
        _logo == widget.product.logo &&
        note == widget.product.note) {
      Navigator.of(context).pop(widget.product);
    } else {
      widget.product.name = _name!;
      widget.product.price = price;
      widget.product.date = _date!;
      widget.product.logo = _logo!;
      widget.product.note = note;
      FrappeAlert.warnAlert(
        title: "Thông báo",
        subtitle: 'Cập nhật thành công !',
        context: context,
      );
      Navigator.of(context).pop(widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 1, top: 1, right: 1),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 10, 20, 20),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
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

                    items: bankDataList
                        .map<DropdownMenuItem<BankListDataModel>>(
                            (BankListDataModel value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new CircleAvatar(
                              backgroundImage: new AssetImage(value.bank_logo),
                            ),
                            // Icon(valueItem.bank_logo),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              value.bank_name,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    isDense: true,
                    onChanged: (BankListDataModel? newSelectedBank) {
                      _onDropDownItemSelected(newSelectedBank!);
                      changeProduct(_bankChoose);
                      print("kkkkkkkkkk" + _bankChoose.bank_logo);
                    },
                    value: _bankChoose,
                  ),
                ),
              );
            },
          ),
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
          controller: _priceController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.send,
          decoration: const InputDecoration(
              labelText: "Giá tiền", prefixIcon: Icon(Icons.money)),
        ),

        TextField(
          // autocorrect: true,
          // autofocus: true,
          enableSuggestions: true,
          textCapitalization: TextCapitalization.sentences,
          controller: _noteController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.send,
          maxLines: null,
          // onSubmitted: (_) => _onSubmittedHandler(context),
          decoration: InputDecoration(
              labelText: "Ghi chú", prefixIcon: Icon(Icons.assignment)),
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
                    changeDate("${DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(
                        date!,
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
