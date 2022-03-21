import 'package:flutter/material.dart';


class Detail_Profile extends StatelessWidget {
  final String lb;
  final String txt;
  final double size;

  Detail_Profile({
    required this.lb,
    required this.txt,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Container(
            height: 60,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Text(lb+' : ',
                      style: TextStyle(
                          fontSize: size,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey)),
                ),

                Expanded(flex: 6,

                  child: Builder(
                    builder: (
                        context,
                        ) {
                      if (txt == "" || txt == null) {
                        return _notDetail();
                      } else {
                        return _Detail();
                      }
                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: Colors.black12)),
          ),
        ),
      ],
    );
  }

  Widget _Detail() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
        child:Text(txt,
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  Widget _notDetail() {
    return
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
          child:Text(' Không có thông tin ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: size,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          backgroundColor: Colors.white70)),
        ),
      );

  }
}
