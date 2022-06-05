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

      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              // height: MediaQuery.of(context).size.height*0.17,
              height: 74,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                            image: AssetImage("assets/images/icons/terrace.png"),
                            fit: BoxFit.fitHeight
                        )
                    ),
                  ),
                  Text('TERRACE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 1.5
                  ),
                  bottom: BorderSide(
                      width: 0.5
                  ),
                )
            ),
                child: buildCategories()),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.5
                          ),
                        )
                    ),
                    height: MediaQuery.of(context).size.height*0.61,
                    child: buildGridView(),
                  ),
                )
            ),
            Container(
              // height: MediaQuery.of(context).size.height*0.15,
              height: 60,
              child: Padding(
                padding: EdgeInsets.all(2),
                // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonTheme(
                      minWidth: 120,
                      height: 50,
                      shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                          borderRadius: BorderRadius.circular(50)),
                      child: RaisedButton(child: Text('취소하기'),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        color: Color(0xffFEADAC),),
                    ),
                    ButtonTheme(
                      minWidth: 120,
                      height: 50,
                      shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                          borderRadius: BorderRadius.circular(50)),
                      child: RaisedButton(child: Text('주문하기'),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PayPage()),
                          );
                        },
                        color: Color(0xff749BE8),
                      ),
                    ),

                  ],
                ),
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

          height: MediaQuery.of(context).size.height*0.07,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffC9D6F9),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Container(

          width: ((MediaQuery.of(context).size.width)/6),
          decoration: BoxDecoration(
              color: selectedIndex == index ? Colors.white : Colors.transparent,
              border: (age >= 15 && age <= 45) ? Border.all(color: Colors.transparent, width: 3,) : Border.all(color: Colors.black, width: 3,),
              borderRadius: BorderRadius.circular(15)
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
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.78,
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
