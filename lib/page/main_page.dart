import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/API/my_api.dart';
import 'package:flutter_kiosk_new/API/naver_api.dart';
import 'package:flutter_kiosk_new/model/MenuList.dart';
import 'package:flutter_kiosk_new/model/attribute.dart';

import 'menu_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CameraDescription camera_dir;
  CameraController _cameraController;
  bool _cameraInitialized = false;

  @override
  void initState() {
    // 화면에 처음 진입할 때 카메라 사용을 준비 하도록 합니다.
    super.initState();
    readyToCamera();
  }

  @override
  void dispose() {
    // 화면에서 벗어날 때 카메라 제어기를 위해 OS에게 할당 받은 리소스를 정리 합니다.
    if (_cameraController != null) {
      _cameraController.dispose();
    }
    super.dispose();
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
        camera_dir, ResolutionPreset.high // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
        );
    _cameraController.initialize().then((value) {
      // 카메라 준비가 끝나면 카메라 미리보기를 보여주기 위해 앱 화면을 다시 그립니다.
      setState(() => _cameraInitialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 120, child: CameraPreview(_cameraController)),
              ),
            ],
          ),
          SizedBox(
            height: 500,
          ),
          FlatButton(color: Colors.deepOrange, onPressed: () async{
            final image = await _cameraController.takePicture();
            checkAttribute(File(image.path));



          }, child: Text('주문하기',style: TextStyle(fontSize: 30),)),
        ],
      ),
    );
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
      MaterialPageRoute(builder: (context)=> MenuPage()),
    );


  }



}
