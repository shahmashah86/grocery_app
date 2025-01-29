import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body:Center(
      child: Lottie.asset(
      "assets/animations/Animation - 1737092875452.json",repeat: false,
      width: 200,
      height: 200,
      fit: BoxFit.fill,),
    ),);
  }
}