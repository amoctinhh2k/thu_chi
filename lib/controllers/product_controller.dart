import 'package:app_thuchi/models/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  late final Product product;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _tiencontroller = TextEditingController();
  late String name,tien;
  void increment() {
    name = _namecontroller.text.trim();
    tien = _tiencontroller.text.trim();
  }
}
