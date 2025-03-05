part of 'user_dashboard_bloc.dart';

sealed class UserDashboardState extends Equatable {
  const UserDashboardState();

  @override
  List<Object?> get props => [];
}

final class UserDashboardInitial extends UserDashboardState {}

final class UserDashboardLoading extends UserDashboardState {}

final class UserDashboardsuccess extends UserDashboardState {
  final UserDashboardModel? dashboardData;

  const UserDashboardsuccess({this.dashboardData});
  @override
  List<Object?> get props => [dashboardData];
}

final class UserDashboardError extends UserDashboardState {
  final String? message;

  const UserDashboardError({this.message});
  @override
   List<Object?> get props => [message];
}
