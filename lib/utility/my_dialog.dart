// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungcarregister/utility/my_constant.dart';
import 'package:ungcarregister/widgets/show_button.dart';
import 'package:ungcarregister/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog(String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ShowText(
          label: title,
          textStyle: MyConstant().h2Style(),
        ),
        content: ShowText(label: message),
        actions: [ShowButton(label: 'OK', pressFunc: ()=> Navigator.pop(context))],
      ),
    );
  }
}
