import 'dart:convert';
import 'package:projetoepi/Constrain/url.dart';
import 'package:projetoepi/Models/colaborador.dart';
import 'package:projetoepi/Models/epi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  int? id;
  String? token;

  Future<List<ColaboradorEpi>> buscarEpis() async {
    var dados = await SharedPreferences.getInstance();
    id = dados.getInt("id");
    token = dados.getString("token");

    final response = await http.get(
        Uri.parse('${AppUrl.baseUrl}api/Colaborador/Epis?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });

        if(response.statusCode == 200){
          List jsonResponse = json.decode(response.body);
          return jsonResponse.map((data) => ColaboradorEpi.fromJson(data)).toList();
        } else{
          throw Exception('Falha ao carregar dados');
        }
  }

  Future<Epi> detalhesEpi(int idEpi) async{
    final response = await http.get(
      Uri.parse('${AppUrl.baseUrl}api/Epi/$idEpi'),
      headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );

    if(response.statusCode == 200){
      return Epi.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Falha ao careregar detalhes do EPI');
    }
  }

}
