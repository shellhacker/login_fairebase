
import 'package:flutter/material.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/auth_provider.dart';
import 'package:login_fairebase/provider/view/Screens/Homepage/widgets/background_color_widgets.dart';
import 'package:login_fairebase/provider/view/Screens/Registerpage/register_screen.dart';
import 'package:login_fairebase/provider/view/Widgets/const.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  @override
 
  void signIn(AuthProvider provider) async {
    final msg = await provider.signIn(context);
    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

    context.read<AuthProvider>().getAllUserDetails(context);
  
  
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return BackgroundColorWidget(
      child: Scaffold(backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('assets/undraw_my_app_re_gxtj.png',),
                  kHeight20 ,
                  TextFormField(
                      controller: authProvider.email,
                      decoration: const InputDecoration(
                        label: Text('E-Mail'),
                        border: OutlineInputBorder(),
                      )),
                  kHeight20,
                  TextFormField(
                      controller: authProvider.password,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(),
                      )),
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterScreen()));
                        },
                        child: const Text('Register',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Color.fromARGB(255, 10, 10, 10)),),
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text('Forgot Password',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Color.fromARGB(255, 10, 10, 10))))
                    ],
                  ),
                  kHeight20,
                  // if(authProvider.loading)CircularProgressIndicator(),
                  // if(!authProvider.loading)
                  SizedBox(
                      child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),
                          onPressed: () => signIn(authProvider),
                          child: const Text('Sign In',style: TextStyle(fontSize: 22,
                          fontWeight:FontWeight.bold,color: Color.fromARGB(255, 252, 250, 250))))),
                  kHeight20,
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
