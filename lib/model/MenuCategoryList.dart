import 'Menu.dart';

class Coffee {
  List<Menu> list;

  static final Coffee _instance = Coffee._internal();

  factory Coffee() {
    return _instance;
  }

  Coffee._internal() {
    list=List();
  }


}

class Ade {
  List<Menu> list;

  static final Ade _instance = Ade._internal();

  factory Ade() {
    return _instance;
  }

  Ade._internal() {
    list=List();
  }

}

class Tea {
  List<Menu> list;

  static final Tea _instance = Tea._internal();

  factory Tea() {
    return _instance;
  }

  Tea._internal() {
    list=List();
  }

}

class NCoffee {
  List<Menu> list;

  static final NCoffee _instance = NCoffee._internal();

  factory NCoffee() {
    return _instance;
  }

  NCoffee._internal() {
    list=List();
  }

}

class Smoothie {
  List<Menu> list;

  static final Smoothie _instance = Smoothie._internal();

  factory Smoothie() {
    return _instance;
  }

  Smoothie._internal() {
    list=List();
  }

}