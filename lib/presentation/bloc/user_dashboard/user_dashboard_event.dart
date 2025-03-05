part of 'user_dashboard_bloc.dart';

sealed class UserDashboardEvent extends Equatable {
  const UserDashboardEvent();

  @override
  List<Object> get props => [];
}

class UserDasboardGet extends UserDashboardEvent {}
