import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/databases/entity/cart_entity.dart';


import 'package:grocery_app/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart';

import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';

import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/get_order/get_orderby_id_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';
import 'package:grocery_app/presentation/screens/splash_screen/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'injection/di.dart' as di;
late final Box<CartEntity> cartBox ;

void main() async {
  di.setup();
  WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
  Hive.registerAdapter(CartEntityAdapter());
// Box
cartBox=  await Hive.openBox<CartEntity>("cartBox");

  runApp(MultiBlocProvider(providers: [
    BlocProvider.value(value: di.getIt<AuthBloc>()),
    BlocProvider.value(value: di.getIt<AdminDashboardBloc>()),
      BlocProvider.value(value: di.getIt<OrdersBloc>()),
      BlocProvider.value(value: di.getIt<CategoryBloc>()),
      BlocProvider.value(value: di.getIt<ProductBloc>()),
         BlocProvider.value(value: di.getIt<GetOrderbyIdBloc>()),
         BlocProvider.value(value: di.getIt<UserDashboardBloc>()),
                BlocProvider.value(value: di.getIt<CartBloc>()),
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
