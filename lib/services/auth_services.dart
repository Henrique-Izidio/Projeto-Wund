import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException({required this.message});
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    authCheck();
  }

  authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        throw AuthException(message: 'A senha é muito fraca.');
      } else if (err.code == 'email-already-in-use') {
        throw AuthException(message: 'Esse email já está cadastrado.');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        throw AuthException(message: 'Email não encontrado.');
      } else if (err.code == 'wrong-password') {
        throw AuthException(message: 'Senha incorreta.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}