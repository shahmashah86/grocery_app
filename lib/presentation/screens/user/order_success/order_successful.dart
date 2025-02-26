import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Orderssuccessful extends StatelessWidget {
  const Orderssuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body:Center(
      child: Column(
        children: [
          Lottie.asset(
          "assets/animations/Animation - 1737092875452.json",repeat: false,
          width: 200,
          height: 200,
          fit: BoxFit.fill,),
          Container()
        ],
      ),
    ),
    
    
    );
  }
}