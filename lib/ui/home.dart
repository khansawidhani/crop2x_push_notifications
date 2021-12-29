import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text(' Crop2x Testing'), 
        centerTitle: true, 

      ),
      body: SafeArea(
        child: Column(
        children: const[
          Text('Hello Crop2x')
        ],
      )),
      
    );
  }
}