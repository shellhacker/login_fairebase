import 'package:flutter/material.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/signup.dart';
import 'package:login_fairebase/provider/view/Screens/Homepage/widgets/background_color_widgets.dart';
import 'package:login_fairebase/provider/view/Screens/Loginpage/login_screen.dart';
import 'package:login_fairebase/provider/view/Widgets/const.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _age.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _place.dispose();

    super.dispose();
  }

  void signUp(SignUp provider) async {
    final msg = await provider.signUp(context);
    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

    // await provider.addUserDetails(
    //   _firstName.text.trim(),
    //   _lastName.text.trim(),
    //   _email.text.trim(),
    //   _age.text.trim(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final signinProvider = context.watch<SignUp>();
    return BackgroundColorWidget(
      child: Scaffold(backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            AssetImage('assets/5847f40ecef1014c0b5e488a.png')),
                    kHeight30,
                    const Text('Creat a New Account',style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 16, 16, 16))),
                                        kHeight20,
                    TextFormField(
                        controller: signinProvider.fistName,
                        decoration: const InputDecoration(
                          label: Text('First Name'),
                          border: OutlineInputBorder(), ),
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'First Name is Empty';
                            }else{
                              return null;
                            }
                          },
                        ),
                    kHeight20,
                    TextFormField(
                        controller: signinProvider.lastName,
                        decoration: const InputDecoration(
                          label: Text('Last Name'),
                          border: OutlineInputBorder(),),
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Last Name is Empty';
                            }else{
                              return null;
                            }
                          },),
                    kHeight20,
                    TextFormField(
                        controller: signinProvider.age,
                        decoration: const InputDecoration(
                          label: Text('Age'),
                          border: OutlineInputBorder(),),
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Age is Empty';
                            }else{
                              return null;
                            }
                          },),
                    kHeight20,
        
                    TextFormField(
                        controller: signinProvider.email,
                        decoration: const InputDecoration(
                          label: Text('E-Mail'),
                          border: OutlineInputBorder(),),
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'E-mail is Empty';
                            }else{
                              return null;
                            }
                          },),
                    kHeight20,
                    TextFormField(
                        controller: signinProvider.password,
                        decoration: const InputDecoration(
                          label: Text('Password'),
                          border: OutlineInputBorder(),),
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Password is Requierd';
                            }else{
                              return null;
                            }
                          },),
                    kHeight20,
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()));
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text('Already have Account ?    ', style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 39, 2, 253))),
                              Text('Login', style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 8, 8, 8))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    kHeight20,
                    SizedBox(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.black),
                            onPressed: () => signUp(signinProvider),
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 249, 248, 248))))),
                    kHeight20,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
