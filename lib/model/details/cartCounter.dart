import 'package:flutter/material.dart';

import '../attribute.dart';
import '../orderList.dart';


class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  var count = CountMenu();
  @override
  Widget build(BuildContext context) {

    count.countMenu = numOfItems;
    return Row(
            children: <Widget>[
              buildOutlineButton(
                icon: Icons.remove,
                press: () {
                  if (numOfItems > 1) {
                    setState(() {
                      numOfItems--;
                    });
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  // if our item is less  then 10 then  it shows 01 02 like that
                  numOfItems.toString().padLeft(2, "0"),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              buildOutlineButton(
                  icon: Icons.add,
                  press: () {
                    setState(() {
                      numOfItems++;
                    });
                  }),
            ],
          );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 50,
      height: 40,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}