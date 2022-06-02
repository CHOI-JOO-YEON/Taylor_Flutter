import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/model/details/detailScreen.dart';
import 'package:flutter_kiosk_new/model/makeDrinkList.dart';
import 'package:flutter_kiosk_new/page/pay_page.dart';

import '../model/MenuCategoryList.dart';
import '../model/itemCard.dart';


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Menu> m = MenuList().list;
  Coffee coffe = new Coffee();
  Ade ade = new Ade();
  Tea tea = new Tea();
  NCoffee ncoffe = new NCoffee();
  Smoothie smoothie = new Smoothie();
  List<Menu> mc;
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(child: Text('결제하기', style: TextStyle(fontSize: 20),),
                      onPressed: (){
                        Navigator.push( context, MaterialPageRoute(builder: (context) => PayPage()),);
                      }
                  )
                ],
              ),
            ),


          ]
      ),


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
      mc = coffe.list;
    }
    else if(selectedIndex == 1){
      mc = ade.list;
    }
    else if(selectedIndex == 2){
      mc = tea.list;
    }
    else if(selectedIndex == 3){
      mc = ncoffe.list;
    }
    else if(selectedIndex == 4){
      mc = smoothie.list;
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




        itemBuilder: (context, index) {
          if(index >= mc.length){
            return Container();
          }
          else {
            Menu a = mc.elementAt(index);
            return ItemCard(
              mn: a,
              press: () =>
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(m: a,))),
              isRecommand: false,
            );
          }

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
