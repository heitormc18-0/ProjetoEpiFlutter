import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoepi/Provider/cadastro/verifica_usuario.dart';
import 'package:projetoepi/Utils/mensagem.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:projetoepi/pages/confirm_password.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastre-se"),
        backgroundColor: const Color(0xffFFC32A),
      ),
      body: const SignupForm(),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  void dispose() {
    _cpfController.clear();
    _emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioCdastro>(builder: (context, usuario, _) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customTextFild(
                title: 'Email',
                controller: _emailController,
                hint: 'Digite seu e-mail',
                tipo: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              customTextFild(
                  title: 'CPF',
                  controller: _cpfController,
                  hint: 'Digite seu cpf',
                  formatacao: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ]),
              const SizedBox(height: 20),
              customButtom(
                  tap: () async {
                    await usuario.checarUsuario(
                        _cpfController.text, _emailController.text);
                    if (usuario.valido) {
                      Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmPassword(
                                    email: _emailController.text,
                                    cpf: _cpfController.text,
                                  )));
                    } else {
                      showMessage(
                          message: usuario.msgError,
                          // ignore: use_build_context_synchronously
                          context: context);
                    }
                  },
                  text: "Avançar",
                  context: context,
                  status: usuario.caregando),
            ],
          ),
        ),
      );
    });
  }
}
