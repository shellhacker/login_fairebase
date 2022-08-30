

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_fairebase/provider/Model/model.dart';
import 'package:login_fairebase/provider/view/Screens/Loginpage/login_screen.dart';

class SignUp extends ChangeNotifier {
  final _fb = FirebaseAuth.instance;

  final bool _isLoading = true;
  final fireStore = FirebaseFirestore.instance;
  UserModel loggedUserModel = UserModel();
  // UserModel userData = UserModel();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fistName=TextEditingController();
  final TextEditingController lastName= TextEditingController();
  final TextEditingController age= TextEditingController();

  Future<String> signUp(context) async {
    try {
      await _fb.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim()).then((value) => 
          addUserDetails(fistName.text.trim(), lastName.text.trim(), email.text.trim(), age.text.trim(),context));
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      return Future.value(ex.message);
    }
  }

  Future addUserDetails(
    String fistName,
    String lastName,
    String email,
    String age,
    //String id
 context ) async {
    User? user = _fb.currentUser;

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'first_name': fistName,
      'last_name': lastName,
      'email': user.email,
      'age': age,
      'uid': user.uid
    });
    notifyListeners();
    Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}
