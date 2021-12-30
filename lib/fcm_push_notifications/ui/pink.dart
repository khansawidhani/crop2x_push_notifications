import 'package:flutter/material.dart';

class Pink extends StatelessWidget {
  const Pink({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.pink,
      body: SafeArea(child: Center(child: Text('Pink screen'),),),
    );
  }
}