
import 'package:flutter/material.dart';
import 'package:projetoepi/Provider/admin/cadepi.dart';
import 'package:projetoepi/Provider/admin/colaborador.dart';
import 'package:projetoepi/Provider/admin/entrega.dart';
import 'package:projetoepi/Provider/cadastro/login.dart';
import 'package:projetoepi/Provider/cadastro/verifica_usuario.dart';
import 'package:projetoepi/login/logar.dart';
import 'package:projetoepi/pages/admin/admin.dart';
import 'package:projetoepi/pages/admin/admin_entrega.dart';
import 'package:projetoepi/pages/admin/admin_epi.dart';
import 'package:projetoepi/pages/admin/admin_func.dart';
import 'package:projetoepi/pages/admin/entrega/data_entrega.dart';
import 'package:projetoepi/pages/admin/entrega/escolheepi.dart';
import 'package:projetoepi/pages/dashboard.dart';
import 'package:projetoepi/pages/homepage.dart';
import 'package:projetoepi/pages/singup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValidarSenha()),
        ChangeNotifierProvider(create: (_) => UsuarioCdastro()),
        ChangeNotifierProvider(create: (_) => Logar()),
        ChangeNotifierProvider(create: (_) => ColaboradorProvider()),
        ChangeNotifierProvider(create: (_) => CadEpiProvider()),
        ChangeNotifierProvider(create: (_) => EntregaProvider()),
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          '/': (context) => const HomePage(),
          '/cadastro': (context) => const SignupScreen(),
          '/dashboard': (context) => const Dashboard(),
          '/admin': (context) => const Admin(),
          '/admentrega': (context) => const AdmEntrega(),
          '/admepi': (context) => const AdminEpi(),
          '/admfunc': (context) => const AdmFunc(),
          '/episentrega': (context) => const EpisScreen(),
          '/entrega': (context) => EntregaScreen(),
        },
        debugShowCheckedModeBanner: false,
      )));
}
