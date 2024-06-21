import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetoepi/Constrain/url.dart';
import 'package:projetoepi/Utils/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ColaboradorProvider with ChangeNotifier {
  bool _carregando = false;
  bool get carregando => _carregando;

  Future cadastrar(
    BuildContext context,
    String nome,
    String ctps,
    String telefone,
    String cpf,
    String email,
    String dataAdmissao,
  ) async {
    var dados = await SharedPreferences.getInstance();
    String? token = dados.getString("token");
    String url = '${AppUrl.baseUrl}api/Colaborador';

    _carregando = true;
    notifyListeners();

    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    telefone = telefone.replaceAll(RegExp(r'[^0-9]'), '');

    DateFormat formatBrasil = DateFormat("dd/MM/yyyy");
    DateTime dataBrParse = formatBrasil.parse(dataAdmissao);

    DateFormat formatAmericano = DateFormat("yyyy-MM-dd");
    String dataAmericana = formatAmericano.format(dataBrParse);

    int cpfparse = int.parse(cpf);
    int telefoneparse = int.parse(telefone);

    Map<String, dynamic> requestBody = {
      "nomeCol": nome,
      "ctps": ctps,
      "telefone": telefoneparse,
      "cpf": cpfparse ,
      "email": email,
      "dataAdmisão": dataAmericana
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
          message: 'Colaborador cadastrado com sucesso!',
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
