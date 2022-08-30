

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/auth_provider.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/edit_controller.dart';
import 'package:login_fairebase/provider/view/Widgets/const.dart';
import 'package:provider/provider.dart';

class HomeScreenWidgets{



static Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return Container(
          height: 100,
          width: double.infinity,
          color: Colors.pink,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Text(
                'choose your profile photo',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                   context.read<UpdateProvider>(). takePic(ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera_front_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                   context.read<UpdateProvider>().takePic(ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.image_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ]),
          ),
        );
      },
    );


  }
static Future<void> updatebnt(context)async {
final authProvider = Provider.of<AuthProvider>(context,listen: false);

      final editProvider = Provider.of<UpdateProvider>(context,listen: false);

    showDialog(
        context: context,
        builder: (index) {
          return AlertDialog(
            title: const Text('Are you sure'),
            
            
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {if (editProvider.firstNameController.text.isEmpty ||
                                            editProvider.firstNameController.text ==
                                                null ||
                                            editProvider.firstNameController.text
                                                .isEmpty ||
                                            editProvider.lastNameController.text ==
                                                null ||
                                            editProvider.lastNameController.text
                                                .isEmpty ||
                                            editProvider.ageController.text ==
                                                null ||
                                            editProvider
                                                .ageController.text.isEmpty ||
                                            editProvider.newImage == null ||
                                            editProvider.newImage.isEmpty) {
                                          editProvider.firstNameController.text ==
                                              authProvider
                                                  .loggedUserModel.firstName;
                                          editProvider.lastNameController.text ==
                                              authProvider
                                                  .loggedUserModel.lastName;
                                          editProvider.ageController.text ==
                                              authProvider.loggedUserModel.age;
                                          editProvider.newImage ==
                                              editProvider.newImage;
                                        }

                                        editProvider.updateUserDetails(context);
                                        Navigator.pop(context);
                       
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 30, 31, 70),
                      ),
                      child: const Text('Yes')),
                       
                    ElevatedButton(
                  onPressed: () { Navigator.pop(context);
                   
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 30, 31, 70),
                  ),
                  child: const Text('No'))
                ],
                
              ),
               
            ],
          );
        });
  }





  
}




      
    




  