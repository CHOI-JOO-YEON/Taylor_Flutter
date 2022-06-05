import 'package:flutter/material.dart';

import '../Menu.dart';
import 'detailBody.dart';



class DetailScreen extends StatelessWidget {
  final Menu m;

  DetailScreen({Key key, this.m}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DetailBody(m: m,)
    );
  }
}