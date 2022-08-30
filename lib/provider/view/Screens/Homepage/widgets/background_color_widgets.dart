import 'package:flutter/material.dart';

class BackgroundColorWidget extends StatelessWidget {
  const BackgroundColorWidget({Key? key, this.child}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.white30, Colors.cyan])),
      child: child,
    );
  }
}
