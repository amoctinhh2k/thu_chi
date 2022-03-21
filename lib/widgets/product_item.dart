import 'package:app_thuchi/controllers/product_store.dart';
import 'package:app_thuchi/models/products.dart';
import 'package:app_thuchi/widgets/ll.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final ProductStore taskStore = ProductStore();

  ProductItem({required this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int sl = 1;
  int tong=0;
int price=0;

  @override
  Widget build(BuildContext context) {
    tong=price;
    price=int.parse(widget.product.price);
    return Card(
      color: Colors.grey[100],
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child:
                      // CarouselWithIndicatorDemo(),
                      Container(
                        //this container is for circular image
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/lon.jpg")),
                        ),
                      ),
                      //     Image.asset(
                      //   "assets/charity.png",
                      // ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              // padding: const EdgeInsets.all(5),
                              padding: const EdgeInsets.fromLTRB(10, 3, 3, 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  // widget.product.price
                                  "$tong"
                                      + " đ",

                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 2,
                      child:
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme
                                .of(context)
                                .accentColor),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                  onTap: () {
                                  tong=tong-price;
                                    sl = sl - 1;
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                padding:
                                EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white),
                                child: Text(
                                  "$sl",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tong=tong+price;
                                      sl = sl + 1;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      //       Image.asset(
                      //   "assets/cash.png",
                      // ),
                    ),
                  ]),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(widget.product.date,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.black45)),
                  )),
            ],
          )),
    );
  }
}
