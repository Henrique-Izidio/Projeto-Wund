import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wund/pages/login_page.dart';
import 'package:wund/services/auth_services.dart';

import '../models/user_repository.dart';

class DrawerConstrutor extends StatefulWidget {
  DrawerConstrutor({Key? key}) : super(key: key);

  @override
  State<DrawerConstrutor> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerConstrutor> {
  final email = TextEditingController();
  final senha = TextEditingController();

  listTileConstrutor(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
      horizontalTitleGap: -10,
    );
  }

  buttonLogout() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: OutlinedButton(
          onPressed: () => context.read<AuthService>().logout(),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.red),
            primary: Colors.red,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Sair do app',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }

  iconeSenha(esconderSenha) {
    if (!esconderSenha) {
      return Icon(
        FontAwesomeIcons.solidEye,
        size: 17,
      );
    } else {
      return Icon(
        FontAwesomeIcons.solidEyeSlash,
        size: 17,
      );
    }
  }

  textSenha(esconderSenha) {
    if (esconderSenha) {
      return true;
    } else {
      return false;
    }
  }

  lerNome() async {
    try {
      String nome = await context.read<UserRepository>().readName();
      return nome;
    } catch (err) {
      print('Ocorreu o erro $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    String nome = lerNome();
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(19, 233, 222, 80),
            Color.fromRGBO(5, 92, 215, 80),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(60),
                child: CircleAvatar(
                  radius: 70,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  listTileConstrutor(Icons.support_agent, 'Suporte'),
                  listTileConstrutor(Icons.info_outlined, 'Sobre'),
                  listTileConstrutor(Icons.settings, 'Configurações')
                ],
              ),
              buttonLogout(),
              Container(
                margin: EdgeInsets.only(top: 240),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wund',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Chewy'),
                    ),
                    Icon(
                      Icons.copyright,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
