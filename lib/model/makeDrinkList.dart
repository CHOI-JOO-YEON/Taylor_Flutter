import 'Menu.dart';
import 'MenuCategoryList.dart';
import 'MenuList.dart';



class MakeList{
  List<Menu> m = MenuList().list;


  Coffee coffe = new Coffee();
  Ade ade = new Ade();
  Tea tea = new Tea();
  NCoffee ncoffe = new NCoffee();
  Smoothie smoothie = new Smoothie();



  addMenu() {
    coffe.list= new List();
    ade.list = new List();
    tea.list = new List();
    ncoffe.list = new List();
    smoothie.list = new List();




    m.sort((a, b) => a.sequence.compareTo(b.sequence));
    // m = List.from(m.reversed);

    for(int i = 0; i < m.length; i++){
      Menu a = m.elementAt(i);
      // Menu b = a;

      if(a.category.contains('ncoffe')){
        ncoffe.list.add(a);
      }
      else if(a.category.contains('ade')){
        ade.list.add(a);
      }
      else if(a.category.contains('tea')){
        tea.list.add(a);
      }
      else if(a.category.contains('coffe')){
        coffe.list.add(a);
      }
      else if(a.category.contains('smoothie')){
        smoothie.list.add(a);
      }

    }
  }
}



