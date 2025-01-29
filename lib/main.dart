import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/auth/auth_repository/auth_repository_impl.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/screens/user/onboarding/onboarding1.dart';

void main() {
 
  runApp(BlocProvider(
    create: (context) => AuthBloc(AuthRepositoryImpl()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboarding1(),
      theme: ThemeData(),
    );
  }
}
