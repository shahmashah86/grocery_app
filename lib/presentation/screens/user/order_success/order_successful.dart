import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Orderssuccessful extends StatelessWidget {
  const Orderssuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body:Center(
      child: Column(spacing: 10,
        children: [SizedBox(height: MediaQuery.sizeOf(context).height*0.1,),
          Lottie.asset(
          "assets/animations/Animation - 1737092875452.json",repeat: false,
          width: 200,
          height: 200,
          fit: BoxFit.fill,),
          Text("Order Placed succesfully",style: TextStyle(fontSize:30,fontWeight: FontWeight.w500 ),),
       
        ],
      ),
    ),
    
    
    );
  }
}