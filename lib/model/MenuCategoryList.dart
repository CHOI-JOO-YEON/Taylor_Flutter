import 'package:flutter_kiosk_new/model/makeDrinkList.dart';

import 'Menu.dart';
import 'MenuCategory.dart';



class Coffee {
  List<MenuCategory> list;

  static final Coffee _instance = Coffee._internal();

  factory Coffee() {
    return _instance;
  }

  Coffee._internal() {
    list=null;
  }

}

class Ade {
  List<MenuCategory> list;

  static final Ade _instance = Ade._internal();

  factory Ade() {
    return _instance;
  }

  Ade._internal() {
    list=null;
  }

}

class Tea {
  List<MenuCategory> list;

  static final Tea _instance = Tea._internal();

  factory Tea() {
    return _instance;
  }

  Tea._internal() {
    list=null;
  }

}

class NCoffee {
  List<MenuCategory> list;

  static final NCoffee _instance = NCoffee._internal();

  factory NCoffee() {
    return _instance;
  }

  NCoffee._internal() {
    list=null;
  }

}

class Smoothie {
  List<MenuCategory> list;

  static final Smoothie _instance = Smoothie._internal();

  factory Smoothie() {
    return _instance;
  }

  Smoothie._internal() {
    list=null;
  }

}