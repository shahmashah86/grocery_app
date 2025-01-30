
import 'package:flutter/material.dart';

import 'package:grocery_app/presentation/screens/user/widgets/bottom_navigation.dart';



class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image(
            image: AssetImage('assets/images/log&reg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        Center(
            child: SizedBox(
          height: 450,
          width: 300,
       
          child: Column(
            children: [
               TextField(
                decoration: InputDecoration(hintText: "username",
                  fillColor: Colors.white,filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
              ),SizedBox(height: 40,),
              TextField(
                decoration: InputDecoration(hintText: "username",
                  fillColor: Colors.white,filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
              ),SizedBox(height: 40,),
              TextField(
                 decoration: InputDecoration(hintText: "password",
                  fillColor: Colors.white,filled: true,
                    enabledBorder: OutlineInputBorder(borderSide:BorderSide.none ),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),),
                    SizedBox(height: 30,),
                    TextButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white),

                    ),
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context){return BottomNavigation(); }));}, child: Center(child: Text("submit"))),
            ],
          ),
        ))
      ]),);
  }
}