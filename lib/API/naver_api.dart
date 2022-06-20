import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> naverApi(File f) async {
  String _client_id = "RGO7PIuuhW5chyOr3kTV";//API 호출 ID
  String _client_secret = "HFOSToSMIZ";// API 호출 비밀번호
  String url = "https://openapi.naver.com/v1/vision/face";//API 호출 URL

  final fixedImageBytes = await FlutterImageCompress.compressWithFile(
    //이미지 방향 수정
    f.path,
    rotate: 0,
    quality: 50,
    keepExif: false,
    autoCorrectionAngle: true,
    format: CompressFormat.jpeg,
  );

  final http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers['X-Naver-Client-Id'] = _client_id;
  request.headers['X-Naver-Client-Secret'] = _client_secret;
  request.files.add(http.MultipartFile.fromBytes('image', fixedImageBytes));

  http.StreamedResponse streamedResponse = await request.send();
  final http.Response response = await http.Response.fromStream(streamedResponse);
  Map<String, dynamic> resultJson = json.decode(response.body);//호출한 JSON을 MAP타입으로 매핑

  if(response.statusCode==400)
    {
      print('에러');
    }
  return resultJson;//MAP 리턴
}
