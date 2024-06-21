import 'package:flutter/material.dart';
import 'package:projetoepi/Provider/admin/entrega.dart';

import 'package:provider/provider.dart';

class EpisScreen extends StatefulWidget {
  const EpisScreen({super.key});

  @override
  State<EpisScreen> createState() => _EpisScreenState();
}

class _EpisScreenState extends State<EpisScreen> {
  @override
  void initState() {
    Provider.of<EntregaProvider>(context, listen: false).fetchEpis();
    super.initState();
  }

  
  void _confirmDelete(BuildContext context, int idEpi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza de que deseja excluir este EPI?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<EntregaProvider>(context, listen: false)
                    .deleteEpi(idEpi);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Entrega - Escolha o Epi'),
      ),
      body: Consumer<EntregaProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.carregando == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Text("Epi para: ${dataProvider.nomeColaborador}"),
                Expanded(
                    child: ListView.builder(
                        itemCount: dataProvider.epis.length,
                        itemBuilder: (context, index) {

                          final epi = dataProvider.epis[index];

                          return ListTile(
                            title: Text(dataProvider.epis[index]['nomeEpi']),
                            subtitle: Text(dataProvider.epis[index]['insUso']),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _confirmDelete(context, epi['idEpi']);
                              },
                            ),
                            onTap: () {
                              dataProvider.setSelectedEpi(
                                  dataProvider.epis[index]['idEpi']);
                              Navigator.pushNamed(context, '/entrega');
                            },
                          );
                        }))
              ],
            );
          }
        },
      ),
    );
  }
}
