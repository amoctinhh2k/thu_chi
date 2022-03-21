import 'package:sembast/sembast.dart';

class Product {
  int? key;
  String name;
  String price;
  String date;

  Product(
      {this.key, required this.name, required this.price, required this.date});

  Product.fromJson(Map<String, dynamic> json, this.key)
      : name = json['name'] as String,
        price = json['price'] as String,
        date = json['date'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'date': date,
      };

  Product.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
      : name = snapshot.value['name'] as String,
        price = snapshot.value['price'] as String,
        date = snapshot.value['date'] as String,
        key = snapshot.key;

  @override
  String toString() {
    return "Product { id: $key, Vật phẩm: $name, giá tiền: $price, Ngày mua: $date }";
  }

  // final List<Product> productList = [
  //   Product(name: "A", price: "10", date: "assets/images/q0.gif"),
  //   Product(name: "B", price: "20", date: "assets/images/qb1.gif"),
  //   Product(name: "C", price: "30", date: "assets/images/qb2.gif"),
  //   Product(name: "D", price: "40", date: "assets/images/q3.gif"),
  //   Product(name: "E", price: "50", date: "assets/images/b1.gif"),
  // ];
}
