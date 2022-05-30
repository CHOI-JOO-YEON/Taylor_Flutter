import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/model/makeDrinkList.dart';

import '../model/MenuCategory.dart';
import '../model/MenuCategoryList.dart';
import '../model/itemCard.dart';
import 'detail_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Menu> m = MenuList().list;
  List<MenuCategory> mc;
  List<String> categories = ["커피", "에이드""\n&주스", "차", "음료", "스무디"];

  int age = Attribute().age;
  String gender = Attribute().gender;
  int selectedIndex = 0;
  int pageIndex = 0;
  int numOfItems = 16, numOfRows = 4, numOfMenu, menuIndex = 0;
  String selectedCategory;

  void initState() {
    super.initState();
    MakeList().addMenu();
  }

  @override
  Widget build(BuildContext context) {
    MakeList().addMenu();
    return Scaffold(
      appBar: AppBar(),
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

  Row buildCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Container(
          height: 60,
          color: Colors.orange,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) => buildCategory(index),
          ),
        ),
      ],
    );

  }

  buildCategory(int index) {
    return GestureDetector(
      child: Container(
        width: ((MediaQuery.of(context).size.width)/5),
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
    if(selectedIndex == 0){
      mc = Coffee().list;
    }
    else if(selectedIndex == 1){
      mc = Ade().list;
    }
    else if(selectedIndex == 2){
      mc = Tea().list;
    }
    else if(selectedIndex == 3){
      mc = NCoffee().list;
    }
    else if(selectedIndex == 4){
      mc = Smoothie().list;
    }

    return GridView.builder(
        padding: EdgeInsets.all(0),
        itemCount: mc.length,
        // itemCount: returnItemCount(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: returnItemRow(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),



        // **여기부터 다시 작성** itemCard 구현해야 함
        itemBuilder: (context, index) {
          MenuCategory a = mc.elementAt(index);
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3
              )
            ),
            child: Column(
              children: [
                Text(a.name),
                Text(a.temp),
                Text(a.price.toString()),
                Text(a.category)
              ],
            ),
          );

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
