import 'package:flutter/material.dart';
import 'Menu.dart';
import 'attribute.dart';

class ItemCard extends StatefulWidget {
  final Menu mn;
  final Function press;
  const ItemCard({
    Key key,
    this.mn,
    this.press,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int age = Attribute().age;

  double imageHeight, imageWidth, titleSize, borderWidth, titlePadding,
      edgePadding;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      // onTap: widget.press, 구현안됨
    );
  }

  Container buildItem() {
    if(age >= 15 && age <= 45) {
      edgePadding = 10 * 3 / 4;
      imageHeight = 85 * 3 / 4;
      imageWidth = 85 * 3 / 4;
      titleSize = 14 * 3 / 4;
      borderWidth = 0;
      titlePadding = 6 * 3 / 4;
    }
    else {
      edgePadding = 10;
      imageHeight = 85;
      imageWidth = 85;
      titleSize = 14;
      borderWidth = 3;
      titlePadding = 6;
    }

    return Container(
        padding: EdgeInsets.all(edgePadding),
        decoration: BoxDecoration(
          color: selectColor(),
          borderRadius: BorderRadius.circular(16),
          border: buildBorder(),
        ),
        child: Column(
          children: [
            Container(
              height: imageHeight,
              width: imageWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  // image: DecorationImage(
                  //     image: AssetImage(widget.product.image),
                  //     fit: BoxFit.cover
                  // ) 사진 구현 안됨
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: titlePadding),
              child: Text(widget.mn.name, textAlign: TextAlign.center,
                style: TextStyle(fontSize: titleSize),),
            ),
          ],
        )
    );
  }

  Border buildBorder(){
    if (age >= 15 && age <= 45) {
      return Border();
    }
    else {
      return Border.all(color: Colors.black, width: 3);
    }

  }

  Color selectColor() {
    if (age >= 15 && age <= 45) {
      return const Color(0xffeeeeee);
    }
    else {
      return widget.mn.temp.contains('HOT') ? Colors.red : Colors.blue;
    }
  }
}

