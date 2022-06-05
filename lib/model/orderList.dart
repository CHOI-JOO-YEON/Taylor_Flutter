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


  Order({
    this.name,
    this.price,
    this.num,
    this.temp,
    this.category,
    this.id
  });

}

List<Order> orders = List();

