import 'package:flutter/material.dart';
import 'package:projetoepi/Utils/mensagem.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:projetoepi/login/logar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Logar>(builder: (context, Logar, _){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFC32A),
        title: const Text("SafeGuard"),
        centerTitle: true,
        leading: Image.asset(
          'assets/images/logo(1).png',
          width: 40,
          height: 40,
          // fit: BoxFit.contain, // Ajustar tamanho da imagem
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
             customTextFild(
              title: 'Email',
              controller: _email,
              hint: 'Digite seu e-mail',
              tipo: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
             customTextFild(
              title: 'Senha',
              controller: _password,
              hint: 'Digite sua senha',
              obscure: true,
              tipo: TextInputType.visiblePassword, 
              funcao: (value){
                Logar.validatePassword(value);
              }             
            ),
            if(Logar.msgError.isNotEmpty)
            Text(
              Logar.msgError,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 30),
            customButtom(
              text: 'Login',
              tap: () async{
                if(_email.text.isEmpty || _password.text.isEmpty){
                  showMessage(
                    message: "Todos os campos são requeridos",
                    context: context
                  );
                } else{
                  await Logar.logarUsuario(_email.text, _password.text, 0);
                  if(Logar.logado) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed(Logar.rota);
                  } else{
                    showMessage(message: "Usuário ou senha",
                    // ignore: use_build_context_synchronously
                    context: context);
                  }
                }
              },
              context: context,
              status: Logar.carregando
            ),
            const SizedBox(height: 30),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cadastro');
              },    
              child: const Text(
                'Cadastre-se agora!',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );});
  }
}
