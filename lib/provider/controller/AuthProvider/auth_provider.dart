import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_fairebase/provider/Model/model.dart';
import 'package:login_fairebase/provider/view/Screens/Homepage/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  final _fb= FirebaseAuth.instance ;

  AuthProvider(context){
    getAllUserDetails(context);
  }
 
  bool _isLoading = true;
  final fireStore = FirebaseFirestore.instance;
  UserModel loggedUserModel = UserModel();
  UserModel userData = UserModel();
  final email = TextEditingController();

  final password = TextEditingController();

  Stream<User?> stream() => _fb.authStateChanges();
  bool get loading => _isLoading;

  Future<String> signIn(context) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _fb
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
         getAllUserDetails(context);
         notifyListeners();
          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()));
         
      });
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;
      notifyListeners();

      return Future.value(ex.message);
    }
  }

  getAllUserDetails(context) async {
    User? user = _fb.currentUser;
    fireStore.collection('users').doc(user!.uid).get().then(
      (value) {
        loggedUserModel = UserModel.fromJson(value.data()!);
        print(loggedUserModel.firstName);
        print(user.email);
        log(loggedUserModel.toString());
        notifyListeners();
      },
    );
  }
}
