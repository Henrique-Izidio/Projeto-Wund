import 'package:flutter/material.dart';
import 'package:wund/pages/pagina_inicial.dart';
import 'package:wund/widgets/auth_check.dart';

import 'pagina_consulta.dart';
import 'home_page.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wund',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: AuthCheck(),
    );
  }
}
