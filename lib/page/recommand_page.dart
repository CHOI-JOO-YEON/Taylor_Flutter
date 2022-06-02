import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/details/detailScreen.dart';
import 'package:flutter_kiosk_new/model/itemCard.dart';
import 'package:flutter_kiosk_new/page/menu_page.dart';

class RecommandPage extends StatelessWidget {
  const RecommandPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Menu> m = MenuList().list;
    return Scaffold(
      appBar: AppBar(),
      body: Column(

        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: buildGridView(m),
              ),
            )
        ),

          buildButton(context, '더 많은 메뉴'),
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context, String a) {
    return Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(child: Text(a, style: TextStyle(fontSize: 20),),
                  onPressed: (){
                    Navigator.push( context, MaterialPageRoute(builder: (context) => MenuPage()),);
                  }
              )
            ],
          ),
        );
  }

  GridView buildGridView(List<Menu> m) {
    return GridView.builder(
        padding: EdgeInsets.all(0),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
          childAspectRatio: 0.75,
        ),




        itemBuilder: (context, index) {
          for (int i = 0; i < m.length; i++) {
            Menu a = m.elementAt(i);
            if(a.sequence == index+1){
              return ItemCard(
                mn: a,
                press: () =>
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(m: a,))),
                isRecommand: true,
              );
            }

          }



        }
    );
  }
}
