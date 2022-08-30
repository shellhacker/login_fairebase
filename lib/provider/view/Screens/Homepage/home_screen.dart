import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/auth_provider.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/edit_controller.dart';
import 'package:login_fairebase/provider/controller/logout_controller.dart';
import 'package:login_fairebase/provider/view/Screens/Homepage/widgets/background_color_widgets.dart';
import 'package:login_fairebase/provider/view/Screens/Homepage/widgets/image_showbottom_sheet.dart';
import 'package:login_fairebase/provider/view/Screens/Loginpage/login_screen.dart';
import 'package:login_fairebase/provider/view/Widgets/common_container_widget.dart';
import 'package:login_fairebase/provider/view/Widgets/const.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // context.read<AuthProvider>().getAllUserDetails(context);
    });
    final user = FirebaseAuth.instance.currentUser;
    final authProvider = context.read<AuthProvider>();
    final editProvider = context.read<UpdateProvider>();
    final formKey = GlobalKey<FormState>();

    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData) return const LoginScreen();
          return BackgroundColorWidget(
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.cyan,
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<Logout>().signOut();
                      },
                      icon: const Icon(Icons.logout),
                      splashRadius: 10,
                    ),
                  ],
                ),
                body: Form(
                  key: formKey,
                  child: ListView(children: [
                    Consumer<UpdateProvider>(builder: (context, value, child) {
                      if (authProvider.loading) {
                        const Center(child: CircularProgressIndicator());
                      }

                      return Center(
                          child: Column(
                        children: [
                          kHeight20,
                          editProvider.newImage.isEmpty
                              ? const CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      AssetImage('assets/pngwing.com (2).png'),
                                )
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundImage: MemoryImage(
                                      const Base64Decoder().convert(
                                          editProvider.newImage.toString())),
                                ),
                          TextButton.icon(
                            onPressed: () {
                              HomeScreenWidgets.showBottomSheet(context);
                            },
                            icon: const Icon(
                              Icons.image,
                              color: Colors.red,
                            ),
                            label: const Text('Upload Image',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 161, 11, 11))),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: NewBox(
                              child: Column(
                                children: [
                                  kHeight10,
                                  TextFormField(
                                    controller: value.firstNameController,
                                    decoration: InputDecoration(
                                      hintText: authProvider
                                          .loggedUserModel.firstName,
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  kHeight20,
                                  TextFormField(
                                    controller: value.lastNameController,
                                    decoration: InputDecoration(
                                      hintText:
                                          authProvider.loggedUserModel.lastName,
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  kHeight20,
                                  TextFormField(
                                      controller: value.ageController,
                                      decoration: InputDecoration(
                                        hintText: authProvider
                                            .loggedUserModel.age
                                            .toString(),
                                        border: const OutlineInputBorder(),
                                      )),
                                  kHeight20,
                                  TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: user!.email.toString(),
                                        border: const OutlineInputBorder(),
                                      )),
                                  kHeight10,
                                ],
                              ),
                            ),
                          ),
                          kHeight20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                    Colors.white30,
                                  )),
                                  onPressed: () {
                                    HomeScreenWidgets.updatebnt(context);},
                                  child: const Text('Save',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 10, 10, 10)))),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                    Colors.white30,
                                  )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Back',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 10, 10, 10)))),
                            ],
                          ),
                        ],
                      ));
                    })
                  ]),
                )),
          );
        });
  }
}
