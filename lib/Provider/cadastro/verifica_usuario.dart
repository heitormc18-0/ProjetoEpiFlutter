import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetoepi/Constrain/url.dart';

class UsuarioCdastro extends ChangeNotifier{
  bool _valido = false;
  String? _msgError;
  bool _caregando = false;

  bool get valido => _valido;
  String get msgError => _msgError!;
  bool get caregando => _caregando;

  final String baseUrl = "${AppUrl.baseUrl}api/Usuario/Check";

  Future checarUsuario(String cpf, String email) async{
    try{
      final response = await http.get(Uri.parse('$baseUrl?Cpf=$cpf&Email=$email'));
      _msgError = '';

      _caregando = false;
      String resposta = '';
      resposta = response.body;

      if(response.statusCode == 200){
        _valido = true;
        _msgError = resposta;
        _caregando = true;
        notifyListeners();
        return _valido;
      }

      if(response.statusCode == 400){
        _msgError = resposta;
        return _valido;
      }
    }
    catch (e){
      _msgError = 'Erro: $e';
      return _valido;
    }
    notifyListeners();
  }
}