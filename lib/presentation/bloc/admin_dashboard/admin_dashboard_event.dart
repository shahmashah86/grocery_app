// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_dashboard_bloc.dart';

sealed class AdminDashboardEvent extends Equatable {
  const AdminDashboardEvent();

  @override
  List<Object> get props => [];
}

class AdminDasboarddataGet  extends AdminDashboardEvent{


}
class UserDashboardGet extends AdminDashboardEvent{

}
class AdminbannerCreation extends AdminDashboardEvent {

 final List<File> imageFile;
  const AdminbannerCreation({
    required this.imageFile,
  });
}
class AdminbannerDeletion extends AdminDashboardEvent {

 final int indextoDelete;
  const AdminbannerDeletion({
    required this.indextoDelete,
  });
}
