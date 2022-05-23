import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';

import '../model/itemCard.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Menu> m = MenuList().list;
  List<String> categories = ["커피", "에이드""\n&주스", "차", "음료", "스무디"];

  int age = Attribute().age;
  String gender = Attribute().gender;
  int selectedIndex = 0;
  int pageIndex = 0;
  int numOfItems = 16, numOfRows = 4;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCategories(),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: buildGridView(),
                  ),
                )
            ),


          ]
      ),

      // body: GridView.builder(
      //   itemCount: m.length,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
      //     childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
      //     mainAxisSpacing: 10, //수평 Padding
      //     crossAxisSpacing: 10, //수직 Padding
      //   ),
      //  itemBuilder: (BuildContext context, int index){
      //    Menu a = m.elementAt(index);
      //    return Container(
      //      alignment: Alignment.center,
      //      child: Column(
      //        children: [
      //          Text(a.name),
      //          Text(a.temp),
      //          Text(a.price.toString()),
      //          Text(a.category)
      //        ],
      //      ),
      //    );
      //  },
      // )





    );
  }

  Container buildCategories() {
    return Container(
          height: 60,
          color: Colors.orange,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) => buildCategory(index),
          ),
        );

  }

  buildCategory(int index) {
    return GestureDetector(
      child: Container(
        width: ((MediaQuery.of(context).size.width/411.4)/5-3),
        decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.white : Colors.orange,
            border: selectedIndex != index ? Border.all(
              color: Colors.black, width: 3,) :
            Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 3,),
                left: BorderSide(
                  color: Colors.black,
                  width: 3,),
                right: BorderSide(
                  color: Colors.black,
                  width: 3,),
                bottom: BorderSide(
                  color: Colors.white,
                  width: 3,)
            )
        ),
        child: Center(
            child:Text(
              categories[index],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black
              ),
            )
        ),
      ),
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  GridView buildGridView() {
    return GridView.builder(
        padding: EdgeInsets.all(0),
        itemCount: returnItemCount(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: returnItemRow(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),



        // **여기부터 다시 작성** itemCard 구현해야 함
        itemBuilder: (context, index) {
          switch (selectedIndex) {
            case 0:
              pr = coffees;
              break;
            case 1:
              pr = adeNjuices;
              break;
            case 2:
              pr = teas;
              break;
            case 3:
              pr = beverages;
              break;
            case 4 :
              pr = smoothies;
              break;
          }
          if(pageIndex == 0){
            if(index >= pr.length){
              return Container();
            }
            else{
              return ItemCard(
                mn: pr[index],
                press: () =>
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(product: pr[index]))),
              );
            }
          }
          else if(index+numOfItems < pr.length){
            return ItemCard(
              product: pr[index+numOfItems],
              press: () => {}
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) =>
                  //         DetailScreen(product: pr[index+numOfItems]))),
            );
          }
          else return Container();
        }
    );
  }

  returnItemCount() {
    if(age >= 15 && age <= 45)
      numOfItems = 16;
    else
      numOfItems = 9;
    return numOfItems;
  }

  returnItemRow() {
    if(age >= 15 && age <= 45)
      numOfRows = 4;
    else
      numOfRows = 3;
    return numOfRows;
  }
}
