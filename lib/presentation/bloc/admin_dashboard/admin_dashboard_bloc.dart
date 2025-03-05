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

//get admin dasboard
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

//create banner
  _createbanner(
      AdminbannerCreation event, Emitter<AdminDashboardState> emit) async {
    final currentState = state;

    if (currentState is AdminDashboardsuccess) {
      try {
        emit(currentState.copyWith(
            isLoading: true,
            isError: false,
            dashboardData: currentState.dashboardData,
            message: '',
            errormsg: ''));
        final response = await adminRepository.bannercreation(event.imageFile);
        log(response.toString());
        emit(currentState.copyWith(
            isLoading: false,
            isError: false,
            dashboardData: currentState.dashboardData,
            message: response.toString(),
            errormsg: ''));
      } catch (e) {
        emit(currentState.copyWith(
            isLoading: false,
            isError: true,
            dashboardData: currentState.dashboardData,
            message: currentState.message,
            dashboardForbanners: currentState.dashboardForbanners,
            errormsg: e.toString()));
        log(e.toString());
      }
    }
  }

//get user dashboard for getting banners
  __getuserDashboard(
      UserDashboardGet event, Emitter<AdminDashboardState> emit) async {
    final currentstate = state;
    if (currentstate is AdminDashboardsuccess) {
      try {
        emit(currentstate.copyWith(
            isLoading: true,
            isError: false,
            dashboardData: currentstate.dashboardData,
            dashboardForbanners: currentstate.dashboardForbanners,
            message: '',
            errormsg: ''));
        final response = await adminRepository.getUserDasboard();
        emit(currentstate.copyWith(
            isLoading: false,
            isError: false,
            dashboardData: currentstate.dashboardData,
            dashboardForbanners: [response],
            message: '',
            errormsg: ''));
      } catch (e) {
        emit(currentstate.copyWith(
            isLoading: false,
            isError: true,
            dashboardData: currentstate.dashboardData,
            dashboardForbanners: currentstate.dashboardForbanners,
            message: '',
            errormsg: e.toString()));
      }
    }
  }

//delete banner
  Future<void> _deletebanner(
      AdminbannerDeletion event, Emitter<AdminDashboardState> emit) async {
    final currentState = state;

    if (currentState is AdminDashboardsuccess) {
      try {
        final response =
            await adminRepository.bannerDelete(event.indextoDelete);
        log(response.toString(), name: 'from bloc');
        emit(currentState.copyWith(
            isLoading: true,
            isError: false,
            dashboardData: currentState.dashboardData,
            dashboardForbanners: List.from(
                currentState.dashboardForbanners as List<AdmindasboardModel?>)
              ..forEach((e) => e.banners
                  ?.removeWhere((test) => test.id == event.indextoDelete)),
            message: response));
      } catch (e) {
        emit(currentState.copyWith(
            isLoading: false,
            isError: false,
            dashboardData: currentState.dashboardData,
            dashboardForbanners: currentState.dashboardForbanners,
            message: '',
            errormsg: e.toString()));
      }
    }
  }
}
