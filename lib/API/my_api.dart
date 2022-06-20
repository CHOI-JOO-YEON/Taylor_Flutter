import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_kiosk_new/model/Menu.dart';
import 'package:http/http.dart' as http;

Future<List<Menu>> myApi(String age, String gender, String temp, String time) async {
  String url = "http://121.127.175.215:9999/response-json";//서버 API 호출

  http.Response response = await http.post(
    url,
    body: <String, dynamic>{'age': age, 'gender': gender, 'temp': temp, 'time': time},
  );
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

  List<Menu> m = parsed.map<Menu>((json) => Menu.fromJson(json)).toList();//받은 JSON List 타입으로 매핑

  return m; // 리스트 리턴
}
