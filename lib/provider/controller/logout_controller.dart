import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Logout extends ChangeNotifier{

final _fb = FirebaseAuth.instance ;

  Future<void> signOut() async {
    await _fb.signOut();
  }
}