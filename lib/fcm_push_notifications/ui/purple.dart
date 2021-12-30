import 'package:flutter/material.dart';

class Purple extends StatelessWidget {
  const Purple({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(child: Center(child: Text('Purple screen'),),),
    );
  }
}