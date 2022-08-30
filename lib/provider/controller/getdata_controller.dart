import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_fairebase/provider/Model/model.dart';

class GetData extends ChangeNotifier {
  final _fb = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  UserModel loggedUserModel = UserModel();

  getUserData(context) async {
    User? user = _fb.currentUser;

    fireStore.collection('users').doc(user!.uid).get().then(
      (value) {
        loggedUserModel = UserModel.fromJson(value.data()!);
        print(loggedUserModel.firstName);
        log(loggedUserModel.toString());
      },
    );
  }
}
