
import 'package:app_thuchi/models/products.dart';
import 'package:flutter/material.dart';



class MyGridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(""
                "Danh sách phân loại vật phẩm"),
          ),
        ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(bankDataList.length, (index) {
                    return Center(
                      child: SelectCard(choice: bankDataList[index],),
                    );
                  }
                  )
              ),
            )

    );
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final BankListDataModel choice;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        color: Colors.white70,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Expanded(child: Icon(choice.icon, size:30.0, color: Colors.white)),
              Expanded(child: Container(
                //this container is for circular image
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(choice.bank_logo)),
                ),
              ),
              ),
              SizedBox(height: 5,),
              Text(""+choice.bank_name, style: TextStyle(color: Colors.black87),),
            ]
        ),
        )
    );
  }
}