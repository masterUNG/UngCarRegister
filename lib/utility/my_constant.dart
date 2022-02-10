import 'package:flutter/material.dart';

class MyConstant {

  // field
  static Color primary = Color.fromARGB(255, 139, 40, 206);
  static Color dark = const Color.fromARGB(255, 38, 38, 148);
  static Color light = const Color.fromARGB(255, 231, 229, 107);

  // method
  TextStyle h1Style() => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: dark,
      );

      TextStyle h2Style() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: dark,
      );

      TextStyle h3Style() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: dark,
      );

       TextStyle h3GreenStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.green,
      );

       TextStyle h3RedStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.red,
      );

       TextStyle h3WhiteStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );
}
