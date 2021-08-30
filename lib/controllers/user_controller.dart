import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// signed - usuário logado
/// unsigned - usuário deslogado
/// loading - usuário carregando
enum AuthState { signed, unsigned, loading }

class UserController extends ChangeNotifier {
  AuthState authState = AuthState.loading;

  final _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  UserController() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        authState = AuthState.signed;
      } else {
        authState = AuthState.unsigned;
      }
      notifyListeners();
    });
  }

  Future<void> login(String email, String senha) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> signup(
    String email,
    String senha,
    Map<String, dynamic> payload,
  ) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    /// TODO: salvar o payload no firestore.
  }
}
