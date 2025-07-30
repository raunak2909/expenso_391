import 'package:flutter/material.dart';

final logoStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final logosubStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300);
final headingStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

final profileStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final login_headingStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue,
  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
);

InputDecoration inputDecoration(String hint) =>
    InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(),
    );

////

TextStyle mTextStyle12({FontWeight mFontWeight = FontWeight
    .w300, Color? textColor}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: mFontWeight,
    color: textColor,
  );
}

TextStyle mTextStyle16({FontWeight mFontWeight = FontWeight
    .w300, Color? textColor}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: mFontWeight,
    color: textColor,
  );
}

TextStyle mTextStyle19({FontWeight mFontWeight = FontWeight
    .w300, Color? textColor}) {
  return TextStyle(
    fontSize: 19,
    fontWeight: mFontWeight,
    color: textColor,
  );
}

TextStyle mTextStyle21({FontWeight mFontWeight = FontWeight
    .w300, Color? textColor}) {
  return TextStyle(
    fontSize: 21,
    fontWeight: mFontWeight,
    color: textColor,
  );
}

TextStyle mTextStyle25({FontWeight mFontWeight = FontWeight
    .w300, Color? textColor}) {
  return TextStyle(
    fontSize: 25,
    fontWeight: mFontWeight,
    color: textColor,
  );
}
