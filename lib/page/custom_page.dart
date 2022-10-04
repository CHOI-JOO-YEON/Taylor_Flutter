import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/API/my_api.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/model/temp.dart';
import 'package:flutter_kiosk_new/page/recommand_page.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class CustomPage extends StatefulWidget {
  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  double age = 25;
  String gender = 'male';
  int _temp = 18;
  String _selectedMenu = '';
  int time = 13;

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
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Slider(
                    activeColor: Colors.amber,
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
            padding: const EdgeInsets.all(4.0),
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
                      activeColor: Colors.red,
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: const Text('추움'),
                      leading: Radio<int>(
                        activeColor: Colors.blue,
                        value: 0 ,
                        groupValue: _temp,
                        onChanged: (int value) {
                          setState(() {
                            _temp = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: const Text('보통'),

                      leading: Radio<int>(
                        activeColor: Colors.green,
                        value: 18 ,
                        groupValue: _temp,
                        onChanged: (int value) {
                          setState(() {
                            _temp = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ListTile(
                      title: const Text('더움'),
                      leading: Radio<int>(
                        activeColor: Colors.red,
                        value: 28 ,
                        groupValue: _temp,
                        onChanged: (int value) {
                          setState(() {
                            _temp = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: Column(
                children: [

                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: const Text('아침'),
                      leading: Radio<int>(
                        activeColor: Colors.yellow,
                        value: 6 ,
                        groupValue: time,
                        onChanged: (int value) {
                          setState(() {
                            time = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: const Text('점심'),

                      leading: Radio<int>(
                        activeColor: Colors.red,
                        value: 13 ,
                        groupValue: time,
                        onChanged: (int value) {
                          setState(() {
                            time = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: const Text('저녁'),
                      leading: Radio<int>(
                        activeColor: Colors.orange,
                        value: 18 ,
                        groupValue: time,
                        onChanged: (int value) {
                          setState(() {
                            time = value;
                          });
                        },
                      ),
                    ),
                  ),SizedBox(

                    child: ListTile(
                      title: const Text('밤'),
                      leading: Radio<int>(
                        activeColor: Colors.indigo,
                        value: 23 ,
                        groupValue: time,
                        onChanged: (int value) {
                          setState(() {
                            time = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Attribute a = new Attribute();
              a.gender = gender;
              a.age = age.floor();
              getMenu(Attribute().age, Attribute().gender, _temp, time);
            },
            child: Text('주문하기'),
          )
        ],
      ),
    ));
  }

  Future<void> getMenu(int age, String gender, int _temp, int time) async {
    Temp temp = new Temp();
    temp.temp = _temp.toDouble();
    var map = await myApi(age.toString(), gender, (_temp+100).toString(), time.toString());
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
