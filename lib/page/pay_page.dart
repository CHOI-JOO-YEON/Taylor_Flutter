import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/model/orderList.dart';
import 'package:flutter_kiosk_new/page/main_page.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_kiosk_new/model/MenuCategoryList.dart';

class PayPage extends StatefulWidget {
  int sum = SumGet().SumG();
  PayPage({Key key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {

    int age = Attribute().age;
    double listHeight = MediaQuery.of(context).size.height*0.6;
    double menuHeight = listHeight/4.1;
    double menuWidth = MediaQuery.of(context).size.width*0.95;
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.20,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.5
                          ),
                        )
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.shopping_cart_outlined, size: 40,),
                            Text('주문내역', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),
                          child: OutlineButton(onPressed: (){
                            setState(() {
                              orders.clear();

                              Navigator.pop(context);
                            });
                          },
                            child: Text('전체삭제', style: TextStyle(color: Colors.grey),),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Column(
              children: [
                Container(
                  color: Colors.black12,
                  height: listHeight,
                  child: buildListView(menuHeight, menuWidth),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.075),
              height: MediaQuery.of(context).size.height*0.2,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.5
                          ),
                          bottom: BorderSide(
                              width: 1.5
                          ),
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.03)),
                        Text('총 금액 : '+widget.sum.toString()+'원', style: TextStyle(fontSize: 25),),
                      ],
                    ),
                  )
                  ,
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTheme(
                          minWidth: 120,
                          height: 50,
                          shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: (age >= 15 && age <= 45) ? Colors.transparent : Colors.black,width: 2),),
                          child: RaisedButton(child: Text('메뉴추가'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            color: Color(0xffEFABFE),),
                        ),
                        ButtonTheme(
                          minWidth: 120,
                          height: 50,
                          shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: (age >= 15 && age <= 45) ? Colors.transparent : Colors.black,width: 2),),
                          child: RaisedButton(child: Text('결제하기'),
                            onPressed: (){
                              orders.clear();


                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainPage()), (route) => false);
                            },
                            color: Color(0xffCDD9FF),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }

  ListView buildListView(double menuHeight, double menuWidth) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: 2),
            child: Container(
              height: menuHeight,
              width: menuWidth,
              decoration: BoxDecoration(
                color: orders[index].temp.contains('HOT') ? Color(0xffFDACAB) : Color(0xffC9D5FB),
                borderRadius: BorderRadius.circular(15), //모서리를 둥글게
                border: Border.all(width: 2), //테두리
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: menuHeight,
                    width: menuHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                            image: AssetImage("assets/images/"+orders[index].category+"/"+orders[index].id.toString()+".PNG"),
                            fit: BoxFit.fitHeight
                        )
                    ),
                  ),
                  Container(
                    width : menuWidth*0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(orders[index].name,style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                        Padding(padding: EdgeInsets.symmetric(vertical: menuHeight/6)),
                        Text(orders[index].price.toString()+'원', style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: menuHeight,
                        width : menuWidth*0.30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(onPressed: (){
                                  setState(() {
                                    orders.removeAt(index);
                                    widget.sum = SumGet().SumG();
                                  });
                                }, icon: Icon(Icons.highlight_off)),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                              child: PayCartCounter(index),
                            ),
                          ],
                        )
                    ),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }

  Row PayCartCounter(int index) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (orders[index].num > 1) {
              setState(() {
                orders[index].num--;
                widget.sum = SumGet().SumG();
              });
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            orders[index].num.toString().padLeft(2, "0"),
            style: TextStyle(fontSize: 14),

          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                orders[index].num++;
                widget.sum = SumGet().SumG();
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 25,
      height: 25,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}

class SumGet{
  int sum = 0;
  SumG(){
    for(int i = 0; i < orders.length; i++)
      sum += (orders[i].price*orders[i].num);
    return sum;
  }
}
