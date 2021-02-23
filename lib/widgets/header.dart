import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText,removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading:removeBackButton? false:true,
    title: Text(
      isAppTitle ? 'Instagram' : titleText,
      style: TextStyle(
          color: Colors.white,
          fontFamily: isAppTitle ? 'VarelaRound' : '',
          fontSize: isAppTitle ? 30.0 : 20),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
