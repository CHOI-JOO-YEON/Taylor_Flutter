import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Menu> m = MenuList().list;

  int age = Attribute().age;
  String gender = Attribute().gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: m.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
          mainAxisSpacing: 10, //수평 Padding
          crossAxisSpacing: 10, //수직 Padding
        ),
       itemBuilder: (BuildContext context, int index){
         Menu a = m.elementAt(index);
         return Container(
           alignment: Alignment.center,
           child: Column(
             children: [
               Text(a.name),
               Text(a.temp),
               Text(a.price.toString())
             ],
           ),
         );
       },
      )


        
      
      
    );
  }
}
