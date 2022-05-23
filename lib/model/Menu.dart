class Menu {
  int sequence;
  int id;
  String name;
  int price;
  bool salesStatus;
  int stock;
  String temp;
  String category;

  Menu(
      {this.sequence,
        this.id,
        this.name,
        this.price,
        this.salesStatus,
        this.stock,
        this.temp,
        this.category});

  Menu.fromJson(Map<String, dynamic> json) {
    sequence = json['sequence'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    salesStatus = json['sales_status'];
    stock = json['stock'];
    temp = json['temp'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sequence'] = this.sequence;
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['sales_status'] = this.salesStatus;
    data['stock'] = this.stock;
    data['temp'] = this.temp;
    data['category'] = this.category;
    return data;
  }
}