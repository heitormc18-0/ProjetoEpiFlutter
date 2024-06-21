import 'package:intl/intl.dart';

class ColaboradorEpi{
  final int idEnt;
  final String dataValidade;
  final String dataEntrega;
  final int idEpi;
  final int idCol;

  ColaboradorEpi({
    required this.idEnt,
    required this.dataValidade,
    required this.dataEntrega, 
    required this.idEpi, 
    required this.idCol, 
    
  });

  factory ColaboradorEpi.fromJson(Map<String, dynamic> json){
    var parsedDV = DateTime.parse(json['dataValidade']);
    // ignore: unused_local_variable
    final databrv = DateFormat("dd/MM/yyyy").format(parsedDV);

    var parsedDE = DateTime.parse(json['dateEntrega']);
    // ignore: unused_local_variable
    final databre = DateFormat("dd/MM/yyyy").format(parsedDE);

    return ColaboradorEpi(
      idEnt: json['idEnt'], 
      dataValidade: databrv.toString(), 
      dataEntrega: databre.toString(),
      idEpi: json['idEpi'], 
      idCol: json['idCol']
      );
  }
}