import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/air.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/model/details/detailScreen.dart';
import 'package:flutter_kiosk_new/model/makeDrinkList.dart';
import 'package:flutter_kiosk_new/model/temp.dart';
import 'package:flutter_kiosk_new/page/pay_page.dart';
import 'package:flutter_kiosk_new/model/orderList.dart';

import 'package:http/http.dart' as http;
import 'package:timer_builder/timer_builder.dart';
import '../model/MenuCategoryList.dart';
import '../model/itemCard.dart';
import 'main_page.dart';
import '../model/air.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final scrollController = ScrollController();
  List<Menu> m = MenuList().list;
  Coffee coffe = new Coffee();
  Ade ade = new Ade();
  Tea tea = new Tea();
  NCoffee ncoffe = new NCoffee();
  Smoothie smoothie = new Smoothie();
  List<Menu> mc;
  List<String> categories = ["커피", "에이드" "\n&주스", "차", "음료", "스무디"];

  int age = Attribute().age;
  String gender = Attribute().gender;
  int selectedIndex = 0;
  int pageIndex = 0;
  int numOfItems = 16, numOfRows = 4, numOfMenu, menuIndex = 0;
  String selectedCategory;
  AirResult _result;

  void initState() {
    super.initState();
    MakeList().addMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
              border: Border(
                  // bottom: BorderSide(
                  //     width: 1.5
                  // ),
                  )),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 45,
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("현재 기온 " + Temp().temp.toStringAsFixed(1) + "℃"),

                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/icons/terrace.png"),
                            fit: BoxFit.fitHeight)),
                  ),
                  SizedBox(
                    height: 45,
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Attribute().age.toString(),
                                style: TextStyle(fontSize: 8)),
                            Text(Attribute().gender,
                                style: TextStyle(fontSize: 8)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                'TERRACE',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(width: 1.5),
              bottom: BorderSide(width: 0.5),
            )),
            child: buildCategories()),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1.5),
            )),
            height: MediaQuery.of(context).size.height * 0.61,
            child: buildGridView(),
          ),
        )),
        Container(
          // height: MediaQuery.of(context).size.height*0.15,
          height: 50,
          child: Padding(
            padding: EdgeInsets.all(2),
            // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonTheme(
                  minWidth: 120,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    //버튼을 둥글게 처리
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: (age >= 15 && age <= 45)
                            ? Colors.transparent
                            : Colors.black,
                        width: 2),
                  ),
                  child: RaisedButton(
                    child: Text('취소하기'),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MainPage()),
                          (route) => false);
                    },
                    color: Color(0xffFEADAC),
                  ),
                ),
                ButtonTheme(
                  minWidth: 120,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    //버튼을 둥글게 처리
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: (age >= 15 && age <= 45)
                            ? Colors.transparent
                            : Colors.black,
                        width: 2),
                  ),
                  child: RaisedButton(
                    child: Text('주문하기'),
                    onPressed: () {
                      if (orders.isEmpty) {
                        return null;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PayPage()),
                        );
                      }
                    },
                    color: Color(0xff749BE8),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ]),
    );
  }

  Row buildCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
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
          width: ((MediaQuery.of(context).size.width) / 6),
          decoration: BoxDecoration(
              color: selectedIndex == index ? Colors.white : Colors.transparent,
              border: (age >= 15 && age <= 45)
                  ? Border.all(
                      color: Colors.transparent,
                      width: 3,
                    )
                  : Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            categories[index],
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          )),
        ),
      ),
      onTap: () async {
        setState(() {
          selectedIndex = index;
        });
        // await Future.delayed(const Duration(milliseconds: 300));
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.minScrollExtent);

          // scrollController.animateTo(
          //     scrollController.position.minScrollExtent,
          //     // duration: Duration(milliseconds: 1),
          //     curve: Curves.fastOutSlowIn
          // );
        });
      },
    );
  }

  GridView buildGridView() {
    if (selectedIndex == 0) {
      mc = coffe.list;
    } else if (selectedIndex == 1) {
      mc = ade.list;
    } else if (selectedIndex == 2) {
      mc = tea.list;
    } else if (selectedIndex == 3) {
      mc = ncoffe.list;
    } else if (selectedIndex == 4) {
      mc = smoothie.list;
    }

    return GridView.builder(
        controller: scrollController,
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
          if (index >= mc.length) {
            return Container();
          } else {
            Menu a = mc.elementAt(index);
            return ItemCard(
              mn: a,
              press: () {
                if (!a.salesStatus) {
                  return null;
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                m: a,
                              )));
                }
              },
              // press: () =>
              //     Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => DetailScreen(
              //               m: a,
              //             ))),
              isRecommand: false,
            );
          }
        });
  }

  returnItemCount() {
    if (age >= 15 && age <= 45)
      numOfItems = 16;
    else
      numOfItems = 9;
    return numOfItems;
  }

  returnItemRow() {
    if (age >= 15 && age <= 45)
      numOfRows = 4;
    else
      numOfRows = 3;
    return numOfRows;
  }
}
