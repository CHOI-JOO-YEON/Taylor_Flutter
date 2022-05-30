import 'Menu.dart';
import 'MenuCategory.dart';
import 'MenuCategoryList.dart';
import 'MenuList.dart';



class MakeList{
  List<Menu> m = MenuList().list;

  List<MenuCategory> coffe = Coffee().list;
  List<MenuCategory> ade = Ade().list;
  List<MenuCategory> tea = Tea().list;
  List<MenuCategory> ncoffe = NCoffee().list;
  List<MenuCategory> smoothie = Smoothie().list;

  addMenu() {
    m.sort((a, b) => a.sequence.compareTo(b.sequence));

    for(int i = 0; i < m.length; i++){
      Menu a = m.elementAt(i);
      MenuCategory b = MenuCategory(a);

      if(a.category.contains('coffe')){
        coffe.add(b);
      }
      else if(a.category.contains('ade')){
        ade.add(b);
      }
      else if(a.category.contains('tea')){
        tea.add(b);
      }
      else if(a.category.contains('ncoffe')){
        ncoffe.add(b);
      }
      else if(a.category.contains('smoothie')){
        smoothie.add(b);
      }

    }
  }
}



