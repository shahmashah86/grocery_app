import 'package:get_it/get_it.dart';
import 'package:grocery_app/data/admin/common/category/category_repository_impl/category_repository_impl.dart';
import 'package:grocery_app/data/admin/common/order_by_id/order_byid_repo_impl/order_byid_repo_impl.dart';
import 'package:grocery_app/data/admin/dasboard/repository_impl/dashboard_repository_impl.dart';
import 'package:grocery_app/data/admin/dasboard/repository_impl/order_repository_impl.dart';
import 'package:grocery_app/data/admin/product_reg/product_reg_repositor_impl/product_reg_repository_impl.dart';
import 'package:grocery_app/data/auth/auth_repository_impl/auth_repository_impl.dart';
import 'package:grocery_app/data/user/dashboard/dasboard_repo_impl/dasboard_repo_impl.dart';
import 'package:grocery_app/domain/admin/common/category/repository/category_reposotory.dart';
import 'package:grocery_app/domain/admin/dashboard/common/repository/order_respository.dart';
import 'package:grocery_app/domain/admin/dashboard/repository/dashboard_repository.dart';
import 'package:grocery_app/domain/admin/product_reg/repository/product_reg_repository.dart';
import 'package:grocery_app/domain/auth/auth_repository/auth_repository.dart';
import 'package:grocery_app/domain/common/model/repository/orde_by_id_repo.dart';
import 'package:grocery_app/domain/user/dashboard/repository/dasboard_repo.dart';
import 'package:grocery_app/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart';

import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';

import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/get_order/get_orderby_id_bloc.dart';

import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';

final getIt=GetIt.instance;
void setup(){
  getIt.registerSingleton<DashboardRepository>(DashboardRepositoryImpl());
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
    getIt.registerSingleton<OrderRespository>(OrderRepositoryImpl());
      getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
         getIt.registerSingleton<ProductRegRepository>(ProductRegRepositoryImpl());
           getIt.registerSingleton<OrdeByIdRepo>(OrderByidRepoImpl());
                getIt.registerSingleton<DasboardRepo>(DasboardRepoImpl());


  getIt.registerSingleton<AdminDashboardBloc>(AdminDashboardBloc(getIt<DashboardRepository>()));
  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AuthRepository>()));
 getIt.registerSingleton<OrdersBloc>(OrdersBloc(getIt<OrderRespository>()));
   getIt.registerSingleton<CategoryBloc>(CategoryBloc(getIt<CategoryRepository>()));
      getIt.registerSingleton<ProductBloc>(ProductBloc(getIt<ProductRegRepository>()));
      getIt.registerSingleton<GetOrderbyIdBloc>(GetOrderbyIdBloc(getIt<OrdeByIdRepo>()));
       getIt.registerSingleton<UserDashboardBloc>(UserDashboardBloc(getIt<DasboardRepo>()));
  
}