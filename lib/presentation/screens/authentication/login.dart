import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/homscreen/admin_homescreen.dart';
import 'package:grocery_app/presentation/screens/authentication/registration.dart';
import 'package:grocery_app/presentation/screens/user/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<String?> readuserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('user_name') ?? "";

    return username;
  }

  final ValueNotifier<bool> isBannerVisible = ValueNotifier<bool>(false);
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController resetController;

  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode resetFocusNode;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    resetController = TextEditingController();
    resetFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

   
   
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    log('changed. didpose.');
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    resetFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logFormkey = GlobalKey<FormState>();

    return Scaffold(backgroundColor: Colors.amber.shade600,
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
                height: MediaQuery.sizeOf(context).height * .4,
                width: 300,
              
                child: Form(
                  key: logFormkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value == '') {
                            return "Empty username field";
                          }
                          // if (value.length < 6) {
                          //   return "Invalid password length";
                          // }

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
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
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
                          if (state is Authupdated &&
                              state.message
                                  .contains('Email sent successfully to')) {
                            log('from log screen', name: 'log screen ');

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    contentPadding:
                                        EdgeInsetsDirectional.all(10),
                                    content: Text(
                                      textAlign: TextAlign.center,
                                      'Email sent succesfully',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    icon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                          size: 60,
                                        )),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.amber.shade300),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                    actionsAlignment: MainAxisAlignment.center,
                                  );
                                });
                          }
                          if (state is Authsuccess &&
                              state.isLoading == false) {
                            log(state.isLoading.toString(),
                                name: 'isloading value');
                            log(state.authModel.isAdmin.toString(),
                                name: "user or admin");

                                  // Hide the MaterialBanner before navigating
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return state.authModel.isAdmin == true
                                  ? AdminHomescreen()
                                  : BottomNavigation();
                            }), (route) => false);
                          }

                          if (state is AuthError) {
                            log("errror");
                            log(state.errormsg.toString());
                            String message = state.errormsg;


                            if (message.contains(
                                'User not registered or check password')) {
                              message = "Incorrect username or password";
                            } else if (message.contains(
                                'The email address is already in use by another account.')) {
                              message = "Email address is already in use";
                            } else if (message
                                .contains('username is already used')) {
                              message = "username is already used try another";
                            } else {
                              message =
                                  state.errormsg;
                            }
                
                    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(state.errormsg),
        leading: Icon(Icons.error, color: Colors.red),
        backgroundColor: Colors.grey[200],
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('Dismiss'),
          ),
        ],
      ),
    );
                     
                            
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            log('circular');
                            return SizedBox(
                              height: 50,
                              width: 50,
                              child: SpinKitFadingCircle(color: Colors.white,),
                            );
                          }

                          return Column(children: [
                            TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      const Color.fromRGBO(255, 255, 255, 1)),
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
                              height:MediaQuery.sizeOf(context).height*.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '---------------------------- ',
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                                Text(' or ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21)),
                                Text(' ----------------------------',
                                    style: TextStyle(color: Colors.white54))
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height*.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    child: Text(
                                      "Dont have account?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                        // Hide the MaterialBanner before navigating
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return Registration();
                                        }),
                                      );
                                     
                                    }),
                                InkWell(
                                    onTap: () {
                                        // Hide the MaterialBanner before navigating
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: BorderSide()),
                                              child: SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        .28,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        'username',
                                                        style: TextStyle(
                                                            fontSize: 22),
                                                      ),
                                                      TextFormField(
                                                        focusNode:
                                                            resetFocusNode,
                                                        cursorHeight: 30,
                                                        controller:
                                                            resetController,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        top: MediaQuery.sizeOf(context).height *
                                                                            .014,
                                                                        bottom:
                                                                            10),
                                                                enabledBorder:
                                                                    UnderlineInputBorder(),

                                                                // Bottom border when focused
                                                                focusedBorder:
                                                                    UnderlineInputBorder(),
                                                                hintText:
                                                                    'Provide your username',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .black45)),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7))),
                                                                  backgroundColor:
                                                                      WidgetStatePropertyAll(Colors
                                                                          .amber
                                                                          .shade200)),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'cancel',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        24),
                                                              )),
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      WidgetStatePropertyAll(Colors
                                                                          .grey
                                                                          .shade300),
                                                                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7)))),
                                                              onPressed: () {
                                                                final String
                                                                    username =
                                                                    resetController
                                                                        .text
                                                                        .trim();
                                                                if (username !=
                                                                    '') {
                                                                  log(username);
                                                                  context
                                                                      .read<
                                                                          AuthBloc>()
                                                                      .add(Resetpassword(
                                                                          userName:
                                                                              username));
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                                resetController
                                                                    .clear();
                                                                resetFocusNode
                                                                    .unfocus();
                                                                return;
                                                              },
                                                              child: Text(
                                                                  'submit',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          24))),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      "forget password?",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            )
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
