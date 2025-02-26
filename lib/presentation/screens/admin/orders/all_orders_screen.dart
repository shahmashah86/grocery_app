import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';

import 'package:grocery_app/domain/orders/model/order_model.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/widgets/content.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order List",
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_left, size: 32)),
        backgroundColor: Colors.amber.shade200,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if(state is OrdersLoading){
            return Center(child: CircularProgressIndicator());
          }




          if (state is Orderssuccess) {



            if (state.orderScreenType == OrderScreenType.allOrders) {
              List<OrdersModel>? orderList = state.allordersList;
              return Content(
                order: orderList,
                fromallordersScreen: true,
              );
            }
            if (state.orderScreenType == OrderScreenType.userWiseOrders) {
              if(state.isLoading==true){
                return Center(child: CircularProgressIndicator());
              }
               if(state.usersorderList.isEmpty){
              log(state.usersorderList.toString(), name: 'allorders list');
              return Center(child: Text('No order is made by this user'));
            }
            else{
        

              List<OrdersModel>? usersorders = state.usersorderList;
              return Content(order: usersorders);
            }
            }
            
          
            if (state.iserror) {
              return Center(child: Text(state.errormessage));
            }
           
          }

          if (state is OrdersError) {
            return Center(child: Text(state.errormessage!));
          }

          return Center(child: Text("something went wrong please try again"));
        },
      ),
    );
  }
}
