import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart';

import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';

import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/get_order/get_orderby_id_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/splash_screen/splash_screen.dart';
import 'injection/di.dart' as di;

void main() {
  di.setup();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(providers: [
    BlocProvider.value(value: di.getIt<AuthBloc>()),
    BlocProvider.value(value: di.getIt<AdminDashboardBloc>()),
      BlocProvider.value(value: di.getIt<OrdersBloc>()),
      BlocProvider.value(value: di.getIt<CategoryBloc>()),
      BlocProvider.value(value: di.getIt<ProductBloc>()),
         BlocProvider.value(value: di.getIt<GetOrderbyIdBloc>())
  ], child: const MyApp()));
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
