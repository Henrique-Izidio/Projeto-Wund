import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wund/carrosel/slide_tile.dart';

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

  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  bool esconderSenha = true;

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      home: Scaffold(
        drawer: Drawer(
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
                    children: [
                      Form(
                          key: _form,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 250,
                                child: TextFormField(
                                  maxLength: 20,
                                  controller: _valor,
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      gapPadding: 2,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    labelText: 'User',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 250,
                                child: TextFormField(
                                  obscureText: textSenha(esconderSenha),
                                  maxLength: 20,
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      gapPadding: 2,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (!esconderSenha) {
                                          setState(() {
                                            esconderSenha = true;
                                          });
                                        } else {
                                          setState(() {
                                            esconderSenha = false;
                                          });
                                        }
                                      },
                                      icon: iconeSenha(esconderSenha),
                                      color: Colors.white,
                                    ),
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          'https://www.shareicon.net/data/256x256/2016/07/10/119930_google_512x512.png'),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          'https://cdn.icon-icons.com/icons2/2429/PNG/128/facebook_logo_icon_147291.png'),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 4, color: Colors.white)),
                                    ),
                                    child: Container(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 5, 20, 5),
                                              child: Text(
                                                'Entrar',
                                                style: TextStyle(
                                                    color: Colors.cyan),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        horizontalTitleGap: -10,
                        title: Text(
                          'Suporte',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        leading: Icon(
                          Icons.support_agent,
                          color: Colors.white,
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        title: Text(
                          'Sobre',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        leading: Icon(
                          Icons.info_outlined,
                          color: Colors.white,
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: -10,
                        title: Text(
                          'Configuração',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        leading: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
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
        ),
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
                width: MediaQuery.of(context).size.width,
                height: 170,
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
