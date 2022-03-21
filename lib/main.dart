import 'package:app_thuchi/pages/list_product.dart';
import 'package:flutter/material.dart';
import 'package:app_thuchi/pages/home.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () =>
          Home()
          // MyApp()
          ),
      GetPage(
        name: '/chitieu',
        page: () => ProductListScreen(),
      ),
    ],
  ));
}

class Home extends GetWidget {
  @override
  Widget build(BuildContext context) {
    Widget open = SplashScreenView(
      navigateRoute:
      // HomeScreen(),
      ProductListScreen(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/charity.png",
      text: "Thu Chi",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: open,
    );
  }
}

