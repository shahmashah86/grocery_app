part of 'admin_dashboard_bloc.dart';

sealed class AdminDashboardState extends Equatable {
  const AdminDashboardState();

  @override
  List<Object?> get props => [];
}

final class AdminDashboardInitial extends AdminDashboardState {}

final class AdminDashboardLoading extends AdminDashboardState {}

final class AdminDashboardsuccess extends AdminDashboardState {
  final bool isLoading;
  final bool isError;
  final AdmindasboardModel dashboardData;
  final List<AdmindasboardModel>? dashboardForbanners;
  final String message;
  final String errormsg;

  const AdminDashboardsuccess(
    this.dashboardData, {
    this.isLoading = false,
    this.isError = false,
    this.dashboardForbanners,
    this.message = '',
    this.errormsg = '',
  });

  @override
  List<Object?> get props => [
        isLoading,
        isError,
        dashboardData,
        dashboardForbanners,
        message,
        errormsg
      ];

  AdminDashboardsuccess copyWith(
      {bool? isLoading,
      bool? isError,
      AdmindasboardModel? dashboardData,
      List<AdmindasboardModel>? dashboardForbanners,
      String? message,
      String? errormsg}) {
    return AdminDashboardsuccess(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        dashboardData ?? this.dashboardData,
        dashboardForbanners: dashboardForbanners ?? this.dashboardForbanners,
        message: message ?? this.message,
        errormsg: errormsg ?? this.errormsg);
  }
}

final class AdminDashboardError extends AdminDashboardState {
  final String? errormessage;

  const AdminDashboardError({this.errormessage});

  @override
  List<Object?> get props => [errormessage];
}
