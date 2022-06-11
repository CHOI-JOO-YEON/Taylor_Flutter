import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/API/my_api.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/page/recommand_page.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class CustomPage extends StatefulWidget {
  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  double age = 25;
  String gender = 'male';
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Slider(
                    value: age,
                    max: 100,
                    divisions: 20,
                    label: age.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        age = value;
                      });
                    },
                  ),
                  Text('나이: ' + age.floor().toString()),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('남자'),
                    leading: Radio<String>(
                      value: 'male',
                      groupValue: gender,
                      onChanged: (String value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('여자'),
                    leading: Radio<String>(
                      value: 'female',
                      groupValue: gender,
                      onChanged: (String value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(onPressed: () {
            Attribute a = new Attribute();
            a.gender = gender;
            a.age = age.floor() ;
            getMenu(Attribute().age,Attribute().gender);

          },child: Text('주문하기'),)
        ],
      ),
    ));
  }
  Future<void> getMenu(int age, String gender) async {
    var map = await myApi(age.toString(), gender);
    MenuList m = new MenuList();
    m.list = map;
    print(map.runtimeType);


    Navigator.push(
      context,
      // MaterialPageRoute(builder: (context)=> MenuPage()),
      MaterialPageRoute(builder: (context) => RecommandPage()),
    );
  }
}
