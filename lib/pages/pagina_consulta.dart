import 'package:flutter/material.dart';
import '../main.dart';
import '../models/profissional_repository.dart';
import 'home_page.dart';
import 'my_app.dart';

class PaginaConsulta extends StatefulWidget {
  PaginaConsulta({Key? key}) : super(key: key);

  @override
  State<PaginaConsulta> createState() => _PaginaConsultaState();
}

class _PaginaConsultaState extends State<PaginaConsulta> {
  @override
  Widget build(BuildContext context) {
    final tabela = ProfissionalRepository.tabela;

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyApp();
            }));
          },
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(19, 233, 222, 100),
            Color.fromRGBO(13, 168, 219, 100),
            Color.fromRGBO(5, 92, 215, 100),
          ])),
        ),
        title: Text('Agendar consulta'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int profissional) {
          return ListTile(
            tileColor: Colors.grey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: Image.asset(
              tabela[profissional].foto,
            ),
            title: Text(
              tabela[profissional].nome,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Consulta: ' + tabela[profissional].consulta.toString()),
                Text('Sessão: ' + tabela[profissional].sessao.toString()),
              ],
            ),
          );
        },
        padding: EdgeInsets.all(20),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: tabela.length,
      ),
    ));
  }
}


