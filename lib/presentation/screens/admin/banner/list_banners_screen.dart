import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/banner/banner_model.dart';
import 'package:grocery_app/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';

class ListBannersScreen extends StatefulWidget {
  const ListBannersScreen({super.key});

  @override
  State<ListBannersScreen> createState() => _ListBannersScreenState();
}

class _ListBannersScreenState extends State<ListBannersScreen> {
  @override
  void initState() {
    context.read<AdminDashboardBloc>().add(UserDashboardGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber.shade200,),
      body: BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
        builder: (context, state) {
          if(state is AdminDashboardLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is AdminDashboardsuccess){
            if(state.isLoading){
                  return Center(child: CircularProgressIndicator(),);

            }
            if(state.isError){
              return Center(child: Center(child: Text(state.errormsg),),);
            }
            
           if(state.dashboardForbanners?.first.banners?.isEmpty??true){
               return Center(child: Text('banner list is empty now'),);

           }
           if(state.dashboardForbanners?.first.banners?.isNotEmpty??false){
            if(state.message=='Banner deleted successfully'){
              log('dd');
              final List<BannerModel>? banners=state.dashboardForbanners!.first.banners;

                return ListView.builder(itemCount:banners!.length ,padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
              
            return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width*.77
                ,child: Card(clipBehavior: Clip.hardEdge,child:Image.network(banners[index].banner),)),
                IconButton(onPressed: (){
 context.read<AdminDashboardBloc>().add(AdminbannerDeletion(indextoDelete: banners[index].id));
     context.read<AdminDashboardBloc>().add(UserDashboardGet());

                }, icon: Icon(Icons.delete))
              ],
            );
                      });
            
            }
            
          final List<BannerModel>? banners=state.dashboardForbanners?.first.banners;

                return ListView.builder(itemCount:banners!.length ,padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
              
            return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width*.77
                ,child: Card(clipBehavior: Clip.hardEdge,child:Image.network(banners[index].banner),)),
                IconButton(onPressed: (){
 context.read<AdminDashboardBloc>().add(AdminbannerDeletion(indextoDelete: banners[index].id));
     context.read<AdminDashboardBloc>().add(UserDashboardGet());

                }, icon: Icon(Icons.delete))
              ],
            );
                      });

           }

          }
        
          if(state is AdminDashboardError){
            return Center(child: Text(state.errormessage??'something is wrong try again'),);
          }
          return Text("Loading please wait or try again");
        },
        
      ),
    );
  }
}
