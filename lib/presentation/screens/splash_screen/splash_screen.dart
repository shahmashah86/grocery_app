import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/admin/homscreen/admin_homescreen.dart';
import 'package:grocery_app/presentation/screens/authentication/login.dart';
import 'package:grocery_app/presentation/screens/user/homeScreen/homescreen.dart';
import 'package:grocery_app/presentation/screens/user/onboarding/onboarding1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

        Future<bool?> readAdminFromPref() async {
    log("From onboarding admin");
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? adminFromAuth = prefs.getBool('adminValue');
    
  log(adminFromAuth.toString(),name: "admin from onbaord");
  // ignore: use_build_context_synchronously
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){   return   tokenFromAuth==""&&? Login():HomeScreen();}), (route)=>false);
    return adminFromAuth;
  }

  
   Future<String?> readtokenFromPref() async {
    log("From onboarding");
    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    bool? isAdmin= await readAdminFromPref();

  log(tokenFromAuth,name: "token check from onboard");
  // ignore: use_build_context_synchronously, unrelated_type_equality_checks
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){   
        if(tokenFromAuth!=""){
       return isAdmin==true?
           AdminHomescreen():isAdmin==false? HomeScreen():Login();
          
        } 
        return Onboarding1();
        // (tokenFromAuth!=""&&isAdmin==true)? Login():HomeScreen();
        
        }
        ), 
        
        (route)=>false);
    return tokenFromAuth;
  }

   @override
  void initState() {
    Future.delayed(Duration(seconds: 7));
    
  readtokenFromPref();


     
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.amber.shade200,
    body: Center(
      // child: CircleAvatar(backgroundImage: AssetImage("assets/adminicon/FreshMart.png"),radius: 60,),

      child: Container(
        height: 200,width: 200,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),image: DecorationImage(image: AssetImage("assets/adminicon/FreshMart.png",),fit: BoxFit.cover)),),
    ),

    );
  }
}