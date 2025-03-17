import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/orders/all_orders_screen.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    context.read<AuthBloc>().add(ListUsers());
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
          if (state is UsersListstate && state.isLoading == true) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersListstate) {
            List<AuthModel>? users = state.users;

            return ListView.builder(
              itemCount: users?.length ?? 0,
              itemBuilder: (context, index) {
                log(users![index].image!, name: "profile image");
                ImageProvider imageProvider = users[index].image != null
                    ? CachedNetworkImageProvider(users[index].image!)
                    : const AssetImage('assets/adminicon/user.jpg');

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * .12,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                           users![index].isAdmin == true
                              ? Colors.green.shade50
                              : Colors.yellow.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: users[index].isAdmin == true
                                  ? Colors.green.shade700
                                  : Colors.lime.shade700)),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<OrdersBloc>()
                              .add(OrdersbyUser(userId: users[index].id!));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AllOrders();
                          }));
                        },
                        child: Row(
                          spacing: 12,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: users[index].image ?? '',
                                  placeholder: (context, url) =>
                                      Image.asset('assets/adminicon/user.jpg'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/adminicon/user.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  users[index].name ?? users[index].email!,
                                  style: TextStyle(fontSize: 17),
                                ),
                                users[index].phoneNumber != null
                                    ? Text(users[index].phoneNumber ?? '',
                                        style: TextStyle(fontSize: 16))
                                    : SizedBox.shrink()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is UsersListError) {
            return Center(child: Text(state.errormsg));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
