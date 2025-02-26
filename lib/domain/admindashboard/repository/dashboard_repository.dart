import 'dart:io';

abstract class DashboardRepository {
  getAdminDashboardData();
  bannercreation(List<File?> imageFile);
  getUserDasboard();
  bannerDelete(int indextoDelete);
  
}