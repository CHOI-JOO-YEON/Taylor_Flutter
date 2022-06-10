import 'package:flutter/cupertino.dart';

import 'Menu.dart';

class CountMenu{
  static final CountMenu _instance = CountMenu._internal();
  int countMenu;

  factory CountMenu(){
    return _instance;
  }

  CountMenu._internal(){
    countMenu = 1;
  }
}

class Order {
  final String name;
  final int price;
  int num;
  final String temp;
  final String category;
  final int id;
  int age;
  String gender;


  Order({
    this.name,
    this.price,
    this.num,
    this.temp,
    this.category,
    this.id,
    this.age,
    this.gender

  });


  Map toJson() =>{
    'name' : name,
    'price' : price,
    'num' : num,
    'temp' : temp,
    'category' : category,
    'id' : id,
    'age': age,
    'gender': gender,
  };


}

List<Order> orders = List();

