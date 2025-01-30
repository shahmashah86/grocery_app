import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/auth/auth_repository/auth_repository_impl.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/screens/splash_screen/splash_screen.dart';


void main() {
    WidgetsFlutterBinding.ensureInitialized();
 
  runApp(BlocProvider(
    create: (context) => AuthBloc(AuthRepositoryImpl()),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    
    );
  }
}
