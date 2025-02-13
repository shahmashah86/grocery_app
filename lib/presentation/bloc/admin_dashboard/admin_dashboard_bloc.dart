import 'dart:developer';
import 'dart:io';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/dashboard/model/admindasboard_model.dart';
import 'package:grocery_app/domain/admin/dashboard/repository/dashboard_repository.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
   final DashboardRepository adminRepository;
  AdminDashboardBloc(this.adminRepository) : super(AdminDashboardInitial()) {
    on<AdminDasboarddataGet>(_getDashboard); 
        on<AdminbannerCreation>(_createbanner); 
  }

_getDashboard(AdminDasboarddataGet event,Emitter<AdminDashboardState> emit) async {
  try{

    final response=await adminRepository.getAdminDashboardData();
    log(response.toString());
    emit(AdminDashboardsuccess(dashboardData: response));
  }
  catch(e){
       emit(AdminDashboardError(message: e.toString()));
      log(e.toString());

  }

}


_createbanner(AdminbannerCreation event ,Emitter<AdminDashboardState> emit) async {
    try{

    final response=await adminRepository.bannercreation(event.imageFile);
    log(response.toString());
    emit(AdminDashboardsuccess());
  }
  catch(e){
       emit(AdminDashboardError(message: e.toString()));
      log(e.toString());

  }

}
  }

