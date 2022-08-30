import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/auth_provider.dart';
import 'package:provider/provider.dart';

class UpdateProvider extends ChangeNotifier {
  final _fb = FirebaseAuth.instance;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  String? image;

  Future<void> updateUserDetails(context) async {
    final authProvider = Provider.of<AuthProvider>(context,listen: false);

    User? user = _fb.currentUser;
    if (firstNameController.text.isEmpty ||
         firstNameController.text == null ||
        lastNameController.text.isEmpty ||
         lastNameController.text == null ||
        ageController.text.isEmpty ||
         ageController.text == null
        ) 
        {
      firstNameController.text == authProvider.loggedUserModel.firstName;
      lastNameController.text==authProvider.loggedUserModel.lastName;
      ageController.text==authProvider.loggedUserModel.age;
    }
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'first_name': firstNameController.text,
      'image': newImage,
      'last_name': lastNameController.text,
      'age': ageController.text,
    });
    notifyListeners();
  }

  File? imagefile;
  String newImage = '';
  takePic(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    final bytes = File(image!.path).readAsBytesSync();
    String imageString = base64Encode(bytes);
    newImage = imageString;
    notifyListeners();
  }
}
