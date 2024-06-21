import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoepi/Style/colors.dart';

Widget customTextFild(
    {String? title,
    String? hint,
    TextEditingController? controller,
    int? maxLines = 1,
    bool? obscure = false,
    TextInputType? tipo = TextInputType.text,
    void Function(String)? funcao,
    List<TextInputFormatter>? formatacao}) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: blue),
        child: TextFormField(
            keyboardType: tipo,
            obscureText: obscure!,
            controller: controller,
            maxLines: maxLines,
            decoration:
                InputDecoration(hintText: hint, border: InputBorder.none),
            onChanged: funcao,
            inputFormatters: formatacao,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '* Preencha o campo';
              }
              return null;
            }),
      )
    ],
  );
}
