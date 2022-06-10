
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_kiosk_new/model/orderList.dart';
import 'package:http/http.dart' as http;
Future<void> OrderApi(List<Order> orders) async{

  String url = "http://121.127.175.215:9999/response-order";


  http.Response response = await http.post(
    url,
//    headers: <String, String>{
//      'Content-Type': 'application/json; charset=UTF-8',
//    },
    body : jsonEncode(orders),
  );
  print(jsonEncode(orders));
  orders.clear();

}