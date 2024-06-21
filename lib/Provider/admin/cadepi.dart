import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projetoepi/Constrain/url.dart';
import 'package:projetoepi/Utils/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CadEpiProvider with ChangeNotifier {
  bool _carregando = false;
  bool get carregando => _carregando;

  Future cadastrar(
    BuildContext context,
    String nome,
    String instrucao,
  ) async {
    var dados = await SharedPreferences.getInstance();
    String? token = dados.getString("token");
    String url = '${AppUrl.baseUrl}api/Epi';
    _carregando = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "insUso": instrucao,
      "nomeEpi": nome,
      "qtd": 1
    };
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );

    _carregando = false;
    notifyListeners();

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("certo");
      showMessage(
          message: 'Epi cadastrado com sucesso!',
          // ignore: use_build_context_synchronously
          context: context);
    } else {
      debugPrint(response.body);
      showMessage(
          message: 'Erro ao cadastrar colaborador!',
          // ignore: use_build_context_synchronously
          context: context);
    }
  }
}
