import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoepi/Provider/admin/colaborador.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Utils/mensagem.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';

class AdmFunc extends StatefulWidget {
  const AdmFunc({super.key});

  @override
  State<AdmFunc> createState() => _AdmFuncState();
}

class _AdmFuncState extends State<AdmFunc> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _ctps = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dataAdmissao = TextEditingController();

  @override
  void dispose() {
    _nome.clear();
    _ctps.clear();
    _telefone.clear();
    _cpf.clear();
    _email.clear();
    _dataAdmissao.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColaboradorProvider>(builder: (context, colabprovider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Administrativo'),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  customTextFild(
                      title: 'Nome do funcionário',
                      controller: _nome,
                      hint: 'Digite o nome do funcionário',
                      tipo: TextInputType.text),
                  customTextFild(
                      title: 'Número CTPS',
                      controller: _ctps,
                      hint: 'Digite o número do CTPS do funcionário',
                      tipo: TextInputType.text),
                  customTextFild(
                      title: 'Número telefone',
                      controller: _telefone,
                      hint: 'Digite o número do telefone do funcionário',
                      tipo: TextInputType.phone,
                      formatacao: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ]),
                  customTextFild(
                      title: 'CPF',
                      controller: _cpf,
                      hint: 'Digite o CPF do funcionário',
                      tipo: TextInputType.number,
                      formatacao: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ]),
                  customTextFild(
                      title: 'Digite o email',
                      controller: _email,
                      hint: 'Digite o email do funcionário',
                      tipo: TextInputType.text),
                  customTextFild(
                      title: 'Data de admissão',
                      controller: _dataAdmissao,
                      hint: 'Digite a data de admissão do funcionário',
                      tipo: TextInputType.datetime,
                      formatacao: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ]),
                  customButtom(tap: () {
                    if (_formKey.currentState!.validate()) {
                      colabprovider.cadastrar(
                          context,
                          _nome.text,
                          _ctps.text,
                          _telefone.text,
                          _cpf.text,
                          _email.text,
                          _dataAdmissao.text);
                    } else {
            
                      showMessage(
                        message: "Todos os campos devem ser preenchidos",
                        context: context,
                      );
                    }
                  },
                  text: "Concluir",
                  context: context,
                  status: colabprovider.carregando
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
