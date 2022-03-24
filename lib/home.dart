import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'models/products.dart';


// class BankListDataModel extends Equatable {
//   final String bank_name;
//   final String bank_logo;
//


List<BankListDataModel> listImg1 = [
  BankListDataModel("Đồ ăn", "assets/an.jpg"),
  BankListDataModel("Mua heo", "assets/lon.jpg"),
  BankListDataModel("Mua xăng", "assets/xang.jpg"),
  BankListDataModel("Quần áo", "assets/ao.jpg"),
  BankListDataModel("Đồ uống", "assets/uong.jpg"),
];


// final List<String> listImg = [
//   "assets/images/q0.gif",
//   "assets/images/qb1.gif",
//   "assets/images/qb3.gif",
//   "assets/images/qb4.gif",
//   "assets/images/qb5.gif",
//
// ];

final List<Widget> imageSliders1 = listImg1
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(
              item.bank_logo, width: 300.0,height: 400.0,
            ),
            // Image.network(item, fit: BoxFit.cover, width: 700.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child:
                Text(
                  item.bank_name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();


class MyHomeScreen extends StatefulWidget {
  @override
  State<MyHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MyHomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 9,
        child: CarouselSlider(
          items: imageSliders1,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listImg1.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}


List<BankListDataModel> list = [
  BankListDataModel("-", "assets/images/q0.gif"),
  BankListDataModel("--", "assets/images/qb1.gif"),
  BankListDataModel("---", "assets/images/qb3.gif"),
  BankListDataModel("----", "assets/images/qb4.gif"),
  BankListDataModel("-----", "assets/images/qb5.gif"),
];



final List<Widget> imageSliders2 = list
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(
              item.bank_logo, width: 300.0,height: 400.0,
            ),
            // Image.network(item, fit: BoxFit.cover, width: 700.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child:
                Text(
                  item.bank_name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();




class MyHomeScreen1 extends StatefulWidget {
  @override
  State<MyHomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<MyHomeScreen1> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 9,
        child: CarouselSlider(
          items: imageSliders2,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
