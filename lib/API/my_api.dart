

import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:http/http.dart' as http;



Future<List<Menu>>  myApi(String age, String gender) async
{
  String url = "http://121.127.175.215:9999/response-json";


  http.Response response = await http.post(
    url,
//    headers: <String, String>{
//      'Content-Type': 'application/json; charset=UTF-8',
//    },
    body: <String, dynamic> {
      'age': age,
      'gender': gender
    },
  );
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

  List<Menu> m =  parsed.map<Menu>((json) => Menu.fromJson(json)).toList();


  return m;











}
