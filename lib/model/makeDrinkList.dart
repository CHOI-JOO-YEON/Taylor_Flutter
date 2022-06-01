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
    m.sort((a, b) => a.sequence.compareTo(b.sequence));

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



