import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: kSecondaryColor, borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
