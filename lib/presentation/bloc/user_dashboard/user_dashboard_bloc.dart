import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/userdashboard/model/user_dashboard_model.dart';

import 'package:grocery_app/domain/userdashboard/repository/dasboard_repo.dart';

part 'user_dashboard_event.dart';
part 'user_dashboard_state.dart';

class UserDashboardBloc extends Bloc<UserDashboardEvent, UserDashboardState> {
  final DashboardRepo userRepository;
  UserDashboardBloc(this.userRepository) : super(UserDashboardInitial()) {
    on<UserDasboardGet>(_getUserDashboard);
  }
  _getUserDashboard(
      UserDasboardGet event, Emitter<UserDashboardState> emit) async {
    try {
      emit(UserDashboardLoading());
      final response = await userRepository.getUserDasboard();

      log(response.toString());
      emit(UserDashboardsuccess(dashboardData: response));
    } catch (e) {
      emit(UserDashboardError(message: e.toString()));
      log(e.toString(), name: 'something wrong');
    }
  }
}
