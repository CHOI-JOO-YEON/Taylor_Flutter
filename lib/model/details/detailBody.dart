import 'package:flutter/material.dart';

import '../Menu.dart';
import '../attribute.dart';
import '../orderList.dart';
import 'cartCounter.dart';



class DetailBody extends StatelessWidget {
  Menu m;
  var count = CountMenu();
  int age = Attribute().age;

  DetailBody({Menu m}){
    this.m = m;
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage("assets/images/icons/terrace.png"),
                          fit: BoxFit.fitHeight
                      ),

                    ),
                  ),
                  Text('TERRACE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.8,
              color: (age >= 15 && age <= 45) ? Color(0xffCAD6FC) : Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.075),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.6,
                      decoration: BoxDecoration(
                        color: (age >= 15 && age <= 45) ? Color(0xffE5E5E5) : m.temp.contains('HOT') ? Color(0xffFDACAB) : Color(0xffC9D5FB),
                        borderRadius: BorderRadius.circular(15), //모서리를 둥글게
                        border: Border.all(width: 2), //테두리
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                            child: Container(
                              height: MediaQuery.of(context).size.width*0.7,
                              width: MediaQuery.of(context).size.width*0.7,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/"+m.category+"/"+m.id.toString()+".PNG"),
                                    fit: BoxFit.fitHeight
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 0,
                                    blurRadius: 5.0,
                                    offset: Offset(0, 10), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(m.name,style: TextStyle(fontSize: 30),),
                          Padding(padding: EdgeInsets.all(10)),
                          Text('가격 : '+m.price.toString()+'원',style: TextStyle(fontSize: 30)),
                          Padding(padding: EdgeInsets.all(10)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('개수', style: TextStyle(fontSize: 30),),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                                CartCounter(),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTheme(
                          minWidth: 120,
                          height: 50,
                          shape: RoundedRectangleBorder(//버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: (age >= 15 && age <= 45) ? Colors.transparent : Colors.black,width: 2), ),

                          child: RaisedButton(child: Text('취소하기'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            color: Colors.white,),
                        ),
                        ButtonTheme(
                          minWidth: 120,
                          height: 50,
                          shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: (age >= 15 && age <= 45) ? Colors.transparent : Colors.black,width: 2), ),
                          child: RaisedButton(child: Text('담기'),
                            onPressed: () {
                              Navigator.pop(context);
                              addToCart();
                            },
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  void addToCart() {
    bool isInCart = false;
    for(int i = 0; i < orders.length; i++){
      if(m.id == orders[i].id){
        orders[i].num += count.countMenu;
        isInCart = true;
      }
    }

    if(!isInCart){
      Order order = Order(
          name: m.name,
          price: m.price,
          num: count.countMenu,
          temp: m.temp,
          category: m.category,
          id: m.id);
      orders.add(order);
    }
  }
}