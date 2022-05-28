import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wund/firebase_options.dart';
import 'package:wund/services/auth_services.dart';
import 'pages/my_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}
