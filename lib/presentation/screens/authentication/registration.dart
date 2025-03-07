import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/screens/authentication/login.dart';


class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
   final regFormkey = GlobalKey<FormState>();
  late final TextEditingController usernameController;
  late TextEditingController emailControler;
  late TextEditingController passwordController;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

                
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailControler = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
  usernameController.dispose();
  passwordController.dispose();
  emailControler.dispose();


        // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amber,
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
            height: MediaQuery.sizeOf(context).height*.4,
            width: 300,
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    validator:(value) {
                     if (value == null || value == '') {
                          return "Empty username field";
                        }
                        if (value.length < 6) {
                          return "Invalid password length";
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
                  SizedBox(height: 40),
                  TextFormField(
                    validator:(value) {
                     if (value == null || value == '') {
                          return "Empty email field";
                        }
                        
                        return null;
                      
                    
                  },
                    controller: emailControler,
                    decoration: InputDecoration(
                        hintText: "email",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    validator:(value) {
                     if (value == null || value == '') {
                          return "Empty password field";
                        }
                        if (value.length < 8) {
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
                  SizedBox(height: 30),

BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
   
     if (state is Authsuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      }
  },
  builder: (context, state) {

    if(state is AuthLoading){
   return SizedBox(
                              height: 50,
                              width: 50,
                              child: SpinKitFadingCircle(color: Colors.white,),
                            );
    }



      return TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed: ()  {
                        //     if(regFormkey.currentState!.validate()){
                        context.read<AuthBloc>().add(AuthSignUp(
                                  username: usernameController!.text.trim(),
                                  email: emailControler!.text.trim(),
                                  password: passwordController!.text.trim(),
                                ));
                        //     }
                                  usernameController!.clear();
                                emailControler!.clear();
                                  passwordController!.clear();
                            
                          },
                          child: Center(child: Text("Submit")),
                        );
  },
)

              
         
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
