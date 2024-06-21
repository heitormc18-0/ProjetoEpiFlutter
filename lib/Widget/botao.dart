import 'package:flutter/material.dart';
import 'package:projetoepi/Style/colors.dart';

Widget customButtom({
  VoidCallback? tap,
  bool? status = false,
  String? text,
  BuildContext? context,
}) {
  return SizedBox(
    width: MediaQuery.of(context!).size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: status == false ? tap: null, 
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.all(16.0)
        ),
        child: Text(
          status == false ? text! : 'Aguarde...',
          style: TextStyle(
            fontSize: 20.0,
            color: white,
          ),
        ),),
    ),
  );
}