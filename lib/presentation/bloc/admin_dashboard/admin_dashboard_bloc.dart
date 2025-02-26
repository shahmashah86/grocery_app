import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admindashboard/model/admindasboard_model.dart';
import 'package:grocery_app/domain/admindashboard/repository/dashboard_repository.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final DashboardRepository adminRepository;
  AdminDashboardBloc(this.adminRepository) : super(AdminDashboardInitial()) {
    on<AdminDasboarddataGet>(_getDashboard);
    on<AdminbannerCreation>(_createbanner);
    on<AdminbannerDeletion>(_deletebanner);
    on<UserDashboardGet>(__getuserDashboard);
  }

  _getDashboard(
      AdminDasboarddataGet event, Emitter<AdminDashboardState> emit) async {
    try {
      emit(AdminDashboardLoading());
      final response = await adminRepository.getAdminDashboardData();

      // log(response.toString());

      emit(AdminDashboardsuccess(response));
    } catch (e) {
      emit(AdminDashboardError(errormessage: e.toString()));
      log(e.toString(), name: 'something wrong');
    }
  }

  _createbanner(
      AdminbannerCreation event, Emitter<AdminDashboardState> emit) async {
    try {
      final currentState = state;

      if (currentState is AdminDashboardsuccess) {
        final response = await adminRepository.bannercreation(event.imageFile);
        log(response.toString());
        emit(currentState.copyWith(message: response.toString()));
      }
    } catch (e) {
      emit(AdminDashboardError(errormessage: e.toString()));
      log(e.toString());
    }
  }

  __getuserDashboard(
      UserDashboardGet event, Emitter<AdminDashboardState> emit) async {
    try {
      emit(AdminDashboardLoading());
      final response = await adminRepository.getUserDasboard();

      log(response.toString());

      emit(AdminDashboardsuccess(response));
    } catch (e) {
      emit(AdminDashboardError(errormessage: e.toString()));
      log(e.toString(), name: 'something wrong');
    }
  }

  Future<void> _deletebanner(
      AdminbannerDeletion event, Emitter<AdminDashboardState> emit) async {
    final currentState = state;
    try {
      if (currentState is AdminDashboardsuccess) {
        final response =
            await adminRepository.bannerDelete(event.indextoDelete);
        log(response.toString());

      }
    } catch (e) {
      emit(AdminDashboardError(errormessage: e.toString()));
      log(e.toString());
    }
  }
}
