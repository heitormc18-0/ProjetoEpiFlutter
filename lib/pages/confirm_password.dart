import 'package:flutter/material.dart';
import 'package:projetoepi/Provider/cadastro/login.dart';
import 'package:projetoepi/Utils/mensagem.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:provider/provider.dart';

class ConfirmPassword extends StatelessWidget {
  final String email;
  final String cpf;

  const ConfirmPassword({super.key, required this.email, required this.cpf});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Consumer<ValidarSenha>(builder: (context, validarsenha, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Confirme a senha'),
          backgroundColor: const Color(0xffFFC32A),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('E-mail: $email'),
                const SizedBox(height: 20),
                Text('CPF: $cpf'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color(0xff5B75A7),
                    labelText: "Senha",
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color(0xff5B75A7),
                    labelText: "Confirmar senha",
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                customButtom(
                    tap: () async {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        showMessage(
                            message: "As senhas devem ser iguais",
                            context: context);
                      } else {
                        var cpfint = cpf.replaceAll(RegExp(r'[^0-9]'), '');
                        await validarsenha.createUser(
                            email, passwordController.text, int.parse(cpfint));
                        showMessage(
                            message: validarsenha.msgErrorApi,
                            // ignore: use_build_context_synchronously
                            context: context);
                      }
                    },
                    text: "Concluir",
                    context: context,
                    status: validarsenha.carregando),
              ],
            ),
          ),
        ),
      );
    });
  }
}
