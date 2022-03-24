import 'package:sembast/sembast.dart';
import 'package:equatable/equatable.dart';


class Product {
  int? key;
  String name;
  String price;
  String date;
  String logo;
  String note;

  Product(
      {this.key, required this.name, required this.price, required this.date,required  this.logo,required this.note,});

  // Product.fromJson(Map<String, dynamic> json, this.key)
  //     : name = json['name'] as String,
  //       price = json['price'] as String,
  //       date = json['date'] as String,
  //       logo = json['logo'] as String,
  //       note = json['note'] as String;


  factory Product.fromJson(Map<String, dynamic> json) => Product(
         name : json['name'] as String,
          price : json['price'] as String,
          date : json['date'] as String,
          logo : json['logo'] as String,
          note : json['note'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'date': date,
    'logo': logo,
    'note': note,
  };

  Product.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
      : name = snapshot.value['name'] as String,
        price = snapshot.value['price'] as String,
        date = snapshot.value['date'] as String,
        logo = snapshot.value['logo'] as String,
        note = snapshot.value['note'] as String,
        key = snapshot.key;

  @override
  String toString() {
    return "{name: $name, price: $price, date: $date, note: $note }";
  }
}

class BankListDataModel extends Equatable {
  final String bank_name;
  final String bank_logo;

  BankListDataModel(this.bank_name, this.bank_logo);
  @override
  List<Object> get props => [bank_name, bank_logo];
}



List<BankListDataModel> bankDataList = [
  BankListDataModel("Đồ ăn", "assets/an.jpg"),
  BankListDataModel("Mua heo", "assets/lon.jpg"),
  BankListDataModel("Mua xăng", "assets/xang.jpg"),
  BankListDataModel("Quần áo", "assets/ao.jpg"),
  BankListDataModel("Đồ uống", "assets/uong.jpg"),

  BankListDataModel("Game", "assets/list_icon/game.png"),
  BankListDataModel("Du lịch", "assets/list_icon/dulich.jpg"),
  BankListDataModel("Điện nước", "assets/list_icon/diennuoc.png"),
  BankListDataModel("Điện thoại", "assets/list_icon/dienthoai.png"),



];
