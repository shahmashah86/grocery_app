part of 'admin_dashboard_bloc.dart';

sealed class AdminDashboardState extends Equatable {
  const AdminDashboardState();
  
  @override
  List<Object> get props => [];
}

final class AdminDashboardInitial extends AdminDashboardState {}
final class AdminDashboardLoading extends AdminDashboardState{}
final class AdminDashboardsuccess extends AdminDashboardState{
final AdmindasboardModel? dashboardData;

 const  AdminDashboardsuccess({this.dashboardData});


}
final class AdminDashboardError extends AdminDashboardState{

final String? message;

 const AdminDashboardError({this.message});

}