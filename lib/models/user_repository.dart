import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wund/database/db_firestore.dart';
import 'package:wund/services/auth_services.dart';

class UserRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;
  late String nome;

  UserRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  saveName(String nome) async {
    try {
      await db
          .collection('usuarios/${auth.usuario!.uid}/detalhes')
          .doc(nome)
          .set({
        'idade': 20,
      });
    } catch (err) {
      debugPrint('Permissão requirida no Firestore: $err');
    }
    notifyListeners();
  }
}
