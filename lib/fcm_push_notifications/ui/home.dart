import 'package:crop2x/fcm_push_notifications/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class TestingScreen extends StatelessWidget {
  TestingScreen({ Key? key }) : super(key: key);
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Crop2x'),
        centerTitle: true, 

      ),
      body: ListView(
        children: const[
          Text('Hello from crop2x'), 
        ],
      ),
    );
  }
}


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( 
//       appBar: AppBar(
//         title: Text(' Crop2x Testing'), 
//         centerTitle: true, 

//       ),
//       body: SafeArea(
//         child: Column(
//         children: const[
//           Text('Hello Crop2x')
//         ],
//       )),
      
//     );
//   }
// }