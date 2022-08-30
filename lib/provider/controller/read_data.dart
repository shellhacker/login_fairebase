import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_fairebase/provider/Model/model.dart';

class ReadData extends ChangeNotifier {
  final fireStore = FirebaseFirestore.instance;
  UserModel loggedUserModel = UserModel();
  UserModel userData = UserModel();
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final _fb = FirebaseAuth.instance;

  getAllUserDetails(context) async {
    User? user = _fb.currentUser;

    fireStore.collection('users').doc(user!.uid).set(userData.toJson());
    fireStore.collection('users').doc(user.uid).get().then(
      (value) {
        loggedUserModel = UserModel.fromJson(value.data()!);
      },
    );
  }
}
