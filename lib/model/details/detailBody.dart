import 'package:flutter/material.dart';

import '../Menu.dart';
import '../orderList.dart';
import 'cartCounter.dart';



class DetailBody extends StatelessWidget {
  Menu m;
  var count = CountMenu();

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
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: MediaQuery.of(context).size.width*0.7,
                width: MediaQuery.of(context).size.width*0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                    border: Border.all(color: Colors.black38, width: 3),
                    image: DecorationImage(
                        image: AssetImage("assets/images/"+m.category+"/"+m.id.toString()+".PNG"),
                        fit: BoxFit.fitHeight
                    )
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 60,
                      child: RaisedButton(child: Text('취소'),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      height: 60,
                      child: RaisedButton(child: Text('확인'),
                          onPressed: () {
                            Navigator.pop(context);
                            addToCart();
                          }),
                    ),
                  ]
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
          id: m.id);
      orders.add(order);
    }
  }
}