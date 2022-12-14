import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/auth_provider.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/edit_controller.dart';
import 'package:login_fairebase/provider/controller/AuthProvider/signup.dart';
import 'package:login_fairebase/provider/controller/logout_controller.dart';
import 'package:login_fairebase/provider/controller/read_data.dart';
import 'package:login_fairebase/provider/view/Screens/Homepage/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(context)),
        ChangeNotifierProvider(create: (_) => ReadData()),
        ChangeNotifierProvider(create: (_) => SignUp()),
        ChangeNotifierProvider(create: (_) => Logout()),
                ChangeNotifierProvider(create: (_) => UpdateProvider()),

        StreamProvider(
            create: (context) => context.watch<AuthProvider>().stream(),
            initialData: null)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
