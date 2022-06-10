import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/API/my_api.dart';
import 'package:flutter_kiosk_new/API/naver_api.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';
import 'package:flutter_kiosk_new/page/custom_page.dart';
import 'package:flutter_kiosk_new/page/recommand_page.dart';

import 'menu_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CameraDescription camera_dir;
  CameraController _cameraController;
  bool _cameraInitialized = false;
  double heightR, widthR;

  @override
  void initState() {
    // 화면에 처음 진입할 때 카메라 사용을 준비 하도록 합니다.
    super.initState();
    readyToCamera();
  }

  @override
  void dispose() {
    // 화면에서 벗어날 때 카메라 제어기를 위해 OS에게 할당 받은 리소스를 정리 합니다.
    // if (_cameraController != null) {
    //   _cameraController.dispose();
    // }
    // super.dispose();
  }

  void readyToCamera() async {
    if (_cameraController == null) {
      final cameras = await availableCameras();
      if (0 == cameras.length) {
        print("not found any cameras");
        return;
      }

      for (var camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          camera_dir = camera;
          break;
        }
      }
    } else {
      final cameras = await availableCameras();
      if (camera_dir.lensDirection == CameraLensDirection.front) {
        for (var camera in cameras) {
          if (camera.lensDirection == CameraLensDirection.back) {
            camera_dir = camera;
            break;
          }
        }
      } else {
        for (var camera in cameras) {
          if (camera.lensDirection == CameraLensDirection.front) {
            camera_dir = camera;
            break;
          }
        }
      }
    }

    _cameraController = CameraController(
        camera_dir, ResolutionPreset.medium // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
    );
    _cameraController.initialize().then((value) {
      // 카메라 준비가 끝나면 카메라 미리보기를 보여주기 위해 앱 화면을 다시 그립니다.
      setState(() => _cameraInitialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    heightR = (MediaQuery.of(context).size.height/820.6);
    widthR = (MediaQuery.of(context).size.width/411.4);
    return  Scaffold(
      body: _cameraController==null?Center(child: CircularProgressIndicator()) : Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Padding(
                padding: EdgeInsets.all(8.0*widthR),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height/6*heightR, child: CameraPreview(_cameraController )),
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height/4*heightR,
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
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
                  
                  Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/30),
                  child: Column(
                    children: [
                      Text('안녕하세요',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('포장 또는 매장 이용을',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('눌러주세요',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),)
                ],
              ),
            ),
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap : goMenuPage,
                  child: isTakeOut('포장')
              ),
              Padding(padding: EdgeInsets.all(20.0*widthR)),
              GestureDetector(
                  onTap : goMenuPage,
                  child: isTakeOut('매장 이용')
              ),

            ],
          ),

          SizedBox(height: 95),
          FlatButton(onPressed: () {

            Navigator.push(context,  MaterialPageRoute(builder: (context)=> CustomPage()),);
          }, child: Text('커스텀')),
        ],
      ),
    );
  }

  Container isTakeOut(String a) {
    String word = '매장 이용';
    String img = 'assets/images/icons/eat.PNG';

    if(a.contains('포장')){
      word = a;
      img = 'assets/images/icons/takeout.PNG';
    }
    return Container(
      height: 130*widthR,
      width: 130*widthR,
      decoration: BoxDecoration(
        color: Color(0xffCDD9FF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 3),
      ),

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8*widthR),
            child: Container(
              height: 75*widthR,
              width: 75*widthR,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.fitHeight
                ),
              ),
            ),
          ),
          Text(a, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  void goMenuPage() async{
    final image = await _cameraController.takePicture();
    checkAttribute(File(image.path));
  }
  Future<void> checkAttribute(File f) async {
    var map = await naverApi(f);
    int age;
    String gender;
    setState(() {
      String callAge = map['faces'][0]['age']['value'];
      gender = map['faces'][0]['gender']['value'];
      age = getAge(callAge);


    });
    print(gender);
    print(age);

    Attribute a = new Attribute();
    a.gender = gender;
    a.age = age;
    getMenu(Attribute().age,Attribute().gender);

  }

  int getAge(String age) {
    var arr = age.split('~');
    return (int.parse(arr[0]) + int.parse(arr[1])) ~/ 2;
  }

  Future<void> getMenu(int age, String gender) async {
    var map = await myApi(age.toString(),gender);
    MenuList m = new MenuList();
    m.list=map;
    print(map.runtimeType);


    Navigator.push(
      context,
      // MaterialPageRoute(builder: (context)=> MenuPage()),
      MaterialPageRoute(builder: (context)=> RecommandPage()),
    );


  }



}
