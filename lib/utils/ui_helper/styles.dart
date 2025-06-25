
import 'package:flutter/material.dart';

final logoStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final logosubStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300);
final headingStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

final profileStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final login_headingStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
);
InputDecoration inputDecoration(String hint) => InputDecoration(
  hintText: hint,
  border: OutlineInputBorder(),
);