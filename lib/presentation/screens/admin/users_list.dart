import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/orders/all_orders_screen.dart';
import 'package:grocery_app/presentation/screens/admin/widgets/contect.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    context.read<AuthBloc>().add(listUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if(state is AuthLoading){
            log("inside loading",name: 'userlistscreen');
      return SpinKitThreeBounce(color: Colors.amberAccent,)
;
          }
if(state is UsersListstate && state.isLoading==true){
  return CircularProgressIndicator();
}


          if(state is UsersListstate){
          List<AuthModel>? users=state.users;

             return ListView.builder(
            itemCount: users!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(color: users[index].isAdmin==true?Colors.green.shade50:Colors.yellow.shade50,
                     
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color:users[index].isAdmin==true?Colors.green.shade700:Colors.lime.shade700)
                        ),
                    child: ListTile(
                      onTap: () {
                        context.read<OrdersBloc>().add(OrdersbyUser(userId: users[index].id!));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AllOrders();
                        }));
                      },
                      leading: CircleAvatar(
                          radius: 40,
                    
                          // foregroundImage:
                              // NetworkImage(users[index].image??users[index].name![0])
                              ),
                      minTileHeight: 100,
                      minVerticalPadding: 20,
                      title: Text(
                      users[index].name!,
                        style: TextStyle(fontSize: 19),
                      ),
                      subtitle: Text(users[index].phoneNumber??'',
                          style: TextStyle(fontSize: 16)),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              );
            },
          );
          }
          if(state is userListError){
            return Center(child: Text("Something is wrong!! try again"));
          }
 return Center(child: Text('please wait and try again'));
     
        },
      ),
    );
  }
}
