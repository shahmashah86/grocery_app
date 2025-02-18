import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';

import 'package:grocery_app/presentation/screens/admin/homscreen/admin_homescreen.dart';

import 'package:grocery_app/presentation/screens/authentication/registration.dart';
import 'package:grocery_app/presentation/screens/user/homeScreen/homescreen.dart';
import 'package:grocery_app/presentation/screens/user/widgets/bottom_navigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final ValueNotifier<bool> isBannerVisible = ValueNotifier<bool>(false);
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
     
    super.dispose();
  }

@override
  void didChangeDependencies() {
      ScaffoldMessenger.of(context) .hideCurrentMaterialBanner();
                  isBannerVisible.value =  false; 
   
                                    

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final logFormkey = GlobalKey<FormState>();

    return Scaffold(
      body: Stack(children: [
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
                height: 300,
                width: 300,
                // color: Colors.blue,
                child: Form(
                  key: logFormkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value == '') {
                            return "Empty username field";
                          }
                          if (value.length < 6) {
                            return "Invalid password length";
                          }

                          return null;
                        },
                        focusNode: usernameFocusNode,
                        controller: usernameController,
                        decoration: InputDecoration(
                            hintText: "username",
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value == '') {
                            return "Empty password field";
                          }
                          if (value.length < 6) {
                            return "Invalid password length";
                          }
                          return null;
                        },
                        focusNode: passwordFocusNode,
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "password",
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is Authsuccess) {
                            log(state.authModel.isAdmin.toString(),name: "user or admin");
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return state.authModel.isAdmin == true
                                  ? AdminHomescreen()
                                  : BottomNavigation();
                            }), (route) => false);
                          }

                          if (state is AuthError) {
                            isBannerVisible.value = true;
                            log("errror");
                            log(state.errormsg.toString());
                            String message =
                                state.errormsg ?? "An unknown error occurred";
                            if (message.contains(
                                'User not registered or check password')) {
                              message = "Incorrect username or password";
                            } else if (message.contains(
                                'The email address is already in use by another account.')) {
                              message = "email address is already in use";
                            } else {
                              message =
                                  "Something went wrong. Please try again later.";
                            }
                            ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                backgroundColor: Colors.red.shade300,
                                leading: const Icon(
                                  Icons.info,
                                  size: 32,
                                ),
                                content: Text(
                                  message,
                                  style: TextStyle(fontSize: 13),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      usernameController.clear();
                                      passwordController.clear();
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                      isBannerVisible.value =
                                          false; // Reset visibility
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );

                            // Show banner
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            log('circular');
                            return SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Column(children: [
                            TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                ),
                                onPressed: () {
                                  if (logFormkey.currentState!.validate()) {
                                    isBannerVisible.value = false;
                                    context.read<AuthBloc>().add((AuthSignin(
                                        username:
                                            usernameController.text.trim(),
                                        password:
                                            passwordController.text.trim())));
                                    usernameFocusNode.unfocus();
                                    passwordFocusNode.unfocus();
                                  }
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
                          ]);
                        },
                      )
                    ],
                  ),
                ))),
      ]),
    );
  }
}
