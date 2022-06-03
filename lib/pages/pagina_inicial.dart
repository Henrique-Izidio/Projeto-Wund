import 'package:flutter/material.dart';
import 'package:wund/carrosel/slide_tile.dart';
import 'package:wund/widgets/drawer_construtor.dart';

class PaginaInicial extends StatefulWidget {
  PaginaInicial({Key? key}) : super(key: key);

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.8);
  int _currentPage = 1;

  var _listSlide = [
    {'id': 0, 'image': 'assets/imagens/img1.jpg'},
    {'id': 1, 'image': 'assets/imagens/img2.jpg'},
    {'id': 2, 'image': 'assets/imagens/img3.png'}
  ];

  @override
  void initState() {
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      home: Scaffold(
        drawer: DrawerConstrutor(),
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(19, 233, 222, 100),
                Color.fromRGBO(13, 168, 219, 100),
                Color.fromRGBO(5, 92, 215, 100),
              ]),
            ),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/imagens/fundo.png'),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _listSlide.length,
                  itemBuilder: (_, int index) {
                    bool activePage = index == _currentPage;
                    return SlideTile(
                      activePage: activePage,
                      image: _listSlide[index]['image'].toString(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}