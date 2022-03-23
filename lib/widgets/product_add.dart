import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/widgets/thuchi_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'item_profile.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'rounded_input_field.dart';
import 'package:app_thuchi/models/products.dart';


class ProductAdd extends StatefulWidget {
  @override
  ProductAddState createState() {
    return new ProductAddState();
  }
}

class ProductAddState extends State<ProductAdd> {
  String date = DateTime.now().toString();
  late String _date,_name,_logo;
  late BankListDataModel _bankChoose;
  final TextEditingController _notecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  bool _validate = false;
  bool _validate1 = false;



  void initState() {
    super.initState();
    _bankChoose = bankDataList[0];
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

  changeProduct(BankListDataModel product){
    _name = product.bank_name;
    _logo = product.bank_logo;
    print("logo");
  }


  _onSubmittedHandler(BuildContext context) {
    _name = _bankChoose.bank_name;
    _logo = _bankChoose.bank_logo;
    String note = _notecontroller.text.trim();
    String price = _pricecontroller.text.trim();
    _date = "${DateFormat('dd-MM-yyyy').format(
      DateTime.parse(
        date,
      ),
    )}";
    if (note.length == 0 || price.length == 0) {
      print("pppppppppp" + _date);
      Navigator.of(context).pop();
    } else {

      print("yyyyyyyy" + _date);
      Product product = Product(name: _name, price: price, date: _date,logo:_logo,note:note);
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
                                  backgroundImage:
                                  new
                                  AssetImage(value.bank_logo),
                                  // AssetImage((value.bank_logo!=null)?"ppppppp":value.bank_logo),
                                ),
                                // Icon(valueItem.bank_logo),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(value.bank_name,style: TextStyle(color: Colors.black54),),
                              ],
                            ),
                          );
                        }).toList(),
                    isExpanded: true,
                    isDense: true,
                    onChanged: (BankListDataModel ?newSelectedBank) {
                      _onDropDownItemSelected(newSelectedBank!);
                       changeProduct(_bankChoose);
                       print("kkkkkkkkkk"+_bankChoose.bank_logo);
                    },
                    value: _bankChoose,
                  ),
                ),
              );
            },
          ),
        ),
        // Down_Button(),
        TextField(
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
          controller: _notecontroller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.send,
          // onSubmitted: (_) => _onSubmittedHandler(context),
          decoration: InputDecoration(
            labelText: "Ghi chú",
            prefixIcon: Icon(Icons.assignment),
            errorText: _validate ? 'Chưa nhập ghi chú !' : null,
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
              _notecontroller.text.isEmpty
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
