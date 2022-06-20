class Temp {
  int temp;
  static final Temp _instance = Temp._internal();

  factory Temp() {
    return _instance;
  }

  Temp._internal() {
    temp = 0;

  }




}