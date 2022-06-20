import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/model/details/detailScreen.dart';
import 'package:flutter_kiosk_new/model/itemCard.dart';
import 'package:flutter_kiosk_new/model/orderList.dart';
import 'package:flutter_kiosk_new/model/temp.dart';
import 'package:flutter_kiosk_new/page/menu_page.dart';
import 'package:flutter_kiosk_new/page/pay_page.dart';
import 'package:timer_builder/timer_builder.dart';

class RecommandPage extends StatelessWidget {
  const RecommandPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Menu> m = MenuList().list;
    int age = Attribute().age;
    String gender = Attribute().gender;
    String printGender;

    if(gender.contains('fe')){
      printGender = '여성';
    }
    else if(gender.contains('male')){
      printGender = '남성';
    }
    else{
      printGender = '미상';
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end  ,
                              children: [
                                Text("현재 기온 " + Temp().temp.toString() + "℃"),
                                TimerBuilder.periodic(
                                    const Duration(seconds: 1),
                                    builder: (context) {
                                      return Text(formatDate(DateTime.now(),
                                          [hh, ':', nn, ':', ss, ' ', am]));
                                    }),

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
                                    image: AssetImage("assets/images/icons/terrace.png"),
                                    fit: BoxFit.fitHeight
                                )
                            ),
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
                                    Text(Attribute().age.toString(),style: TextStyle(fontSize: 8)),
                                    Text(Attribute().gender, style: TextStyle(fontSize: 8)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text('TERRACE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.blue,
            height: MediaQuery.of(context).size.height*0.7,
            width: MediaQuery.of(context).size.width*0.95,
            decoration: BoxDecoration(
              // color: (age >= 15 && age <= 45) ? Color(0xffCDD9FF) : Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(15), //모서리를 둥글게
              border: Border.all(width: 2), //테두리
            ),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center
                  ,children: [
                  Text(age.toString()[0]+'0대 '+printGender+' 추천메뉴', style: TextStyle(fontSize: 20),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.45,
                  )
                ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                    child: Container(
                      child: buildGridView(m),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 150,
                      height: 50,
                      shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: (age >= 15 && age <= 45) ? Colors.transparent : Colors.black,width: 2), ),
                      child: RaisedButton(child: Text('더 많은 메뉴 보기 >', style: TextStyle(fontSize: 15),),
                        onPressed: (){
                          Navigator.push( context, MaterialPageRoute(builder: (context) => MenuPage()),);
                        },
                        color: Color(0xffFFF7AC),
                      ),
                    ),
                  ],
                ),
              ),Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 150,
                      height: 50,
                      shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: (age >= 15 && age <= 45) ? Colors.transparent : Colors.black,width: 2), ),
                      child: RaisedButton(child: Text('결제하기 >', style: TextStyle(fontSize: 20),),
                        onPressed: (){
                          if (orders.isEmpty) {
                            return null;
                          }else {
                            Navigator.push( context, MaterialPageRoute(builder: (context) => PayPage()),);
                          }

                        },
                        color: Color(0xff749BE8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
          // buildButton(context, '더 많은 메뉴'),
        ],
      ),
    );
  }


  GridView buildGridView(List<Menu> m) {

    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.82,
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
