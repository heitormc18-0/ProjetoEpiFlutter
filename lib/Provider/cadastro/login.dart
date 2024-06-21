import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetoepi/Constrain/url.dart';

class ValidarSenha extends ChangeNotifier{
  bool _valido = false;
  String _msgError = '';
  String _msgErrorApi = '';
  bool _carregando = false;

  bool get ehvalido => _valido;
  String get msgError => _msgError;
  String get msgErrorApi => _msgErrorApi;
  bool get carregando => _carregando;

  void  validatePassword(String password){
    _msgError = '';

    if(password.length < 8){
      _msgError = 'Mínimo 8 dígitos';
    }

    else if(!password.contains(RegExp(r'[a-z]'))){
      _msgError = 'Pelo menos uma letra minúscula';
    }
        else if(!password.contains(RegExp(r'[A-Z]'))){
      _msgError = 'Pelo menos uma letra maiúscula';
    }

        else if(!password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{};:.<>\/?]'))){
      _msgError = 'Pelo menos um carácter especial';
    }

        else if(!password.contains(RegExp(r'[0-9]'))){
      _msgError = 'Pelo menos um número';
    }

    _valido = _msgError.isEmpty;
    notifyListeners();
  }


//Criar Usuário
  Future createUser(String email, String password, int cpf) async{
    String url = '${AppUrl.baseUrl}api/Usuario/Criar';

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
      'cpf': cpf,
    };
    _carregando = false;
    
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(requestBody),
    );
    if(response.statusCode == 200){
      _carregando = true;
      _msgErrorApi = "Usuário Cadastrado com sucesso";
      notifyListeners();
    } else{
      _msgErrorApi = response.body;
      notifyListeners();
    }
  }
}



