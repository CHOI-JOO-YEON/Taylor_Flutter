class Attribute {
  int age;
  String gender;

  static final Attribute _instance = Attribute._internal();

  factory Attribute() {
    return _instance;
  }

  Attribute._internal() {
    age = 0;
    gender = "UNKNOWN";

  }




}