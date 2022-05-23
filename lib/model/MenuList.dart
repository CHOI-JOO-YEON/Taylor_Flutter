import 'Menu.dart';

class MenuList {
  List<Menu> list;

  static final MenuList _instance = MenuList._internal();

  factory MenuList() {
    return _instance;
  }

  MenuList._internal() {
    list=null;
  }




}