import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/widgets/contect.dart';

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
          if(state is Orderssuccess && state.allordersList!.isNotEmpty && state.usersorderList!.isEmpty){
          List<OrdersModel>? orderList =state.allordersList;
         return Content(order:orderList,fromallordersScreen: true, );       

          }
            if(state is Orderssuccess && state.usersorderList!.isNotEmpty && state.allordersList!.isEmpty){

          List<OrdersModel>? usersrders =state.usersorderList;
         return Content(order:usersrders);

             
  
          }
          if(state is OrdersError){
            return Text(state.errormessage!);
          }
          return
  Text("something went wrong");
        },
      ),
    );
  }
}
