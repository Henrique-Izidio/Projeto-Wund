import 'package:flutter/material.dart';
import 'package:wund/pages/pagina_consulta.dart';

import 'pagina_inicial.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: pc,
          children: [
            PaginaInicial(),
            PaginaConsulta(),
          ],
          onPageChanged: setPaginaAtual,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_search_outlined),
              label: 'Agendar',
            ),
          ],
          onTap: (pagina) {
            pc.animateToPage(
              pagina,
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          },
          // backgroundColor: Colors.grey[100],
        ),
      ),
    );
  }
}
