import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';

import 'package:grocery_app/presentation/screens/admin/homscreen/admin_homescreen.dart';

import 'package:grocery_app/presentation/screens/authentication/registration.dart';
import 'package:grocery_app/presentation/screens/user/homeScreen/homescreen.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
     final logFormkey = GlobalKey<FormState>();

    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image(
            image: AssetImage('assets/images/log&reg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        Center(
            child: Container(
          height: 300,
          width: 300,
          // color: Colors.blue,
          child: Form(
              key: logFormkey,
            child: Column(
              children: [
                TextFormField(validator: (value) {
                   if (value == null || value == '') {
                        return "Empty username field";
                      }
                      if (value.length < 8) {
                        return "Invalid length";
                      }
                      return null;
                    
                },
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: "username",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none)),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(obscureText: true,validator:(value) {
                   if (value == null || value == '') {
                        return "Empty password field";
                      }
                      if (value.length < 7) {
                        return "Invalid password length";
                      }
                      return null;
                    
                  
                },
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: "password",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none)),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(children: [
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed: () {
                          
                          },
                          child: Center(child: Text("submit"))),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                          child: Text(
                            "Dont have account? register now",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Registration();
                                }),
                              ))
                    ])
               
              ],
            ),
          )
        )),
      
      ]),
    );
  }
}
