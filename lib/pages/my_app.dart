import 'package:flutter/material.dart';

import 'pagina_consulta.dart';
import 'pagina_inicial.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _opcaoSelecionada = 0;

  setPaginaAtual(opcao) {
    setState(() {
      _opcaoSelecionada = opcao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_search_outlined),
              label: 'Agendar',),
          ],
          currentIndex: _opcaoSelecionada,
          onTap: setPaginaAtual,
        ),
        body: IndexedStack(
          index: _opcaoSelecionada,
          children: <Widget>[
            PaginaInicial(),
            PaginaConsulta(),
          ],
        ),
      ),
    );
  }
}
