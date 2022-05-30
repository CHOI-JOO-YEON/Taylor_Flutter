import 'Menu.dart';

class MenuCategory {
  int sequence;
  int id;
  String name;
  int price;
  bool salesStatus;
  int stock;
  String temp;
  String category;

  MenuCategory(Menu a){
    sequence = this.sequence;
    id = this.id;
    name = this.name;
    price = this.price;
    salesStatus = this.salesStatus;
    stock = this.stock;
    temp = this.temp;
    category = this.category;
  }
// MenuCategory(
//     {this.sequence,
//       this.id,
//       this.name,
//       this.price,
//       this.salesStatus,
//       this.stock,
//       this.temp,
//       this.category});
}