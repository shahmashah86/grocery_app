import 'package:get_it/get_it.dart';
import 'package:grocery_app/data/admin_dasboard/respositoray_impl/dashboard_repository_impl.dart';

import 'package:grocery_app/data/auth/auth_repository_impl/auth_repository_impl.dart';
import 'package:grocery_app/data/cart/cart_repository_iml/cart_repository_impl.dart';
import 'package:grocery_app/data/category/category_repository_impl/category_repository_impl.dart';

import 'package:grocery_app/data/order/repository_impl/order_repository_impl.dart';
import 'package:grocery_app/data/products/repository/product_repository_impl.dart';
import 'package:grocery_app/data/user_dashboard/user_dashboard_repo_impl/user_dashboard_repo_impl.dart';
import 'package:grocery_app/domain/admindashboard/repository/dashboard_repository.dart';

import 'package:grocery_app/domain/auth/auth_repository/auth_repository.dart';
import 'package:grocery_app/domain/cart/cart_respository/cart_respository.dart';
import 'package:grocery_app/domain/category/repository/category_reposotory.dart';

import 'package:grocery_app/domain/orders/repository/order_respository.dart';
import 'package:grocery_app/domain/products/repository/product_repository.dart';

import 'package:grocery_app/domain/userdashboard/repository/dasboard_repo.dart';
import 'package:grocery_app/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart';

import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';

import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';

import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<DashboardRepository>(DashboardRepositoryImpl());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<OrderRespository>(OrderRepositoryImpl());
  getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  getIt.registerSingleton<DashboardRepo>(UserDashboardRepoImpl());
  getIt.registerSingleton<CartRespository>(CartRepositoryImpl());


  

  getIt.registerSingleton<AdminDashboardBloc>(
      AdminDashboardBloc(getIt<DashboardRepository>()));
  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AuthRepository>()));
  getIt.registerSingleton<OrdersBloc>(OrdersBloc(getIt<OrderRespository>()));
  getIt.registerSingleton<CategoryBloc>(
      CategoryBloc(getIt<CategoryRepository>()));
  getIt.registerSingleton<ProductBloc>(ProductBloc(getIt<ProductRepository>()));
  getIt.registerSingleton<UserDashboardBloc>(
      UserDashboardBloc(getIt<DashboardRepo>()));
  getIt.registerSingleton<CartBloc>(CartBloc(getIt<CartRespository>()));
}
