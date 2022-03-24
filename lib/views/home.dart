import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// final List<String> listImg = [
//   "https://i.ytimg.com/vi/A2a7WXWS8vs/maxresdefault.jpg",
//   "https://i.ytimg.com/vi/Y5oxD5K0Y6Y/maxresdefault.jpg",
//   "https://i.ytimg.com/vi/JbZ0Vpft_dg/maxresdefault.jpg",
//   "https://i.ytimg.com/vi/BEkvmWhbUqk/maxresdefault.jpg",
//   "https://i.ytimg.com/vi/M1HOPNHaP8Q/maxresdefault.jpg",
// ];

final List<String> listImg = [
  "assets/images/q0.gif",
  "assets/images/qb1.gif",
  "assets/images/qb3.gif",
  "assets/images/qb4.gif",
  "assets/images/qb5.gif",
];

final List<Widget> imageSliders = listImg
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                        Image.asset(
                      item,fit: BoxFit.cover, width: 50.0,height: 30.0,
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
                            vertical: 10.0, horizontal: 20.0),
                        child:
                        Text(
                          // ' ${listImg.indexOf(item)} '
                              'image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
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

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: imageSliders,
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listImg.asMap().entries.map((entry) {
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
    ]);
  }
}
