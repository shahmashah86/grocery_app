part of 'admin_dashboard_bloc.dart';

sealed class AdminDashboardState extends Equatable {
  const AdminDashboardState();

  @override
  List<Object?> get props => [];
}

final class AdminDashboardInitial extends AdminDashboardState {}

final class AdminDashboardLoading extends AdminDashboardState {}

final class AdminDashboardsuccess extends AdminDashboardState {
  final AdmindasboardModel dashboardData;
  final String message;


  const AdminDashboardsuccess(
     this.dashboardData, {this.message=''}
     
     );

  @override
  List<Object?> get props => [dashboardData,message];

  AdminDashboardsuccess copyWith({
    AdmindasboardModel? dashboardData,
    String? message,
  }) {
    return AdminDashboardsuccess(
      dashboardData ?? this.dashboardData,
      message: message ?? this.message,
    );
  }
}

final class AdminDashboardError extends AdminDashboardState {
  final String? errormessage;

  const AdminDashboardError({this.errormessage});

  @override
  List<Object?> get props => [errormessage];
}
