import 'package:flutter/material.dart';
import 'package:projetoepi/Models/colaborador.dart';
import 'package:projetoepi/Models/epi.dart';
import 'package:projetoepi/Services/epis.dart';
import 'package:projetoepi/Utils/mensagem.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ApiServices _apiService = ApiServices();
  List<ColaboradorEpi> _epis = [];

  @override
  void initState() {
    super.initState();
    _consumirEpis();
  }

  Future<void> _consumirEpis() async {
    try {
      List<ColaboradorEpi> epis = await _apiService.buscarEpis();
      setState(() {
        _epis = epis;
      });
    } catch (e) {
      showMessage(
          message: "Erro ao carregar dados...",
          // ignore: use_build_context_synchronously
          context: context);
    }
  }

  void _mostrarEpisDetalhes(int idEpi) async {
    try {
      Epi epiDetails = await _apiService.detalhesEpi(idEpi);
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(epiDetails.nome),
              content: Text(epiDetails.instrucaoUso),
              actions: <Widget>[
                TextButton(
                  child: const Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } catch (e) {
      showMessage(
          message: "Erro ao carregar informações da entrega",
          // ignore: use_build_context_synchronously
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de EPIs'),
      ),
      body: ListView.builder(
        itemCount: _epis.length,
        itemBuilder: (context, index) {
          final epi = _epis[index];
          return ListTile(
            title: Text('Data de Validade: ${epi.dataValidade}'),
            subtitle: Text('Data de Entrega: ${epi.dataEntrega}'),
            onTap: () => _mostrarEpisDetalhes(epi.idEpi),
          );
        },
      ),
    );
  }
}
