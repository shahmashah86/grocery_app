import 'dart:developer';

// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/domain/orders/model/order_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';

import 'package:grocery_app/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart';

import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';

import 'package:grocery_app/presentation/screens/admin/banner/create_banner_screen.dart';
import 'package:grocery_app/presentation/screens/admin/category/get_AllCategory.dart';

import 'package:grocery_app/presentation/screens/admin/orders/all_orders_screen.dart';
import 'package:grocery_app/presentation/screens/admin/product/product_list_screen.dart';
import 'package:grocery_app/presentation/screens/admin/product/productcreate.dart';
import 'package:grocery_app/presentation/screens/admin/product/trending_products.dart';
import 'package:grocery_app/presentation/screens/admin/stock/stockout_screen.dart';

import 'package:grocery_app/presentation/screens/admin/user_list/users_list.dart';


import 'package:grocery_app/presentation/screens/authentication/login.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomescreen extends StatefulWidget {
  const AdminHomescreen({super.key});

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {
  @override
  void initState() {
    context.read<AdminDashboardBloc>().add(AdminDasboarddataGet());
    context.read<OrdersBloc>().add(OrdersListGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 252, 250, 245),
      drawer: Drawer(
        backgroundColor: Colors.amber.shade50,
        child: ListView(
          children: [
            Container(height: MediaQuery.sizeOf(context).height*.14,padding: EdgeInsets.all(30),
              color: Colors.amber.shade200,child: Text("Menu",style: TextStyle(fontSize: 22,),),
            ),
            InkWell(
                child: ListTile(
              title: Text("Home"),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AdminHomescreen();
              })),
            )),
            Divider(),
            InkWell(
                child: ListTile(
                  title: Text("Categories"),
                ),
                onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Getallcategory();
                    }))),
            Divider(),
            InkWell(
                onTap: () {
                  context.read<OrdersBloc>().add(OrdersListGet());
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AllOrders();
                  }));
                },
                child: ListTile(
                  title: Text("Orders"),
                )),
            Divider(),
            InkWell(
              child: ListTile(
                  title: Text("Stock"),
                  onTap: () {
                    context.read<ProductBloc>().add(ProductstockGet());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StockoutScreen();
                    }));
                  }),
            ),
            Divider(),
            InkWell(
                child: ListTile(
                  title: Text("Products"),
                ),
                onTap: () {
                  context.read<ProductBloc>().add(ProductList());

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductListScreen();
                  }));
                }),
            Divider(),
            InkWell(
                child: ListTile(
                  title: Text("Product Registration"),
                ),
                onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Productcreate(
                        buttonMode: ProductButtonMode.add,
                      );
                    }))),
            Divider(),
            InkWell(
                child: ListTile(
                  title: Text("Banner Registration"),
                ),
                onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateBannerScreen();
                    }))),
            Divider(),
            ListTile(
              title: Row(
                children: [
                  Text("Signout"),
                  IconButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();

                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }), (route) => false);
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor:Colors.amber.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(spacing: 10,
           
            children: [
             
              BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  if(state is OrdersLoading){
                    log('ordersloading...');
                      return Center(child: CircularProgressIndicator());
                  }
                  if(state is Orderssuccess&& state.isLoading){
                    return Center(child: CircularProgressIndicator());
                  }
                        int totalsales = 0; 
                  if (state is Orderssuccess && state.allordersList.isNotEmpty) {
                    List<OrdersModel>? orders = state.allordersList;
                    for (var i = 0; i < orders.length; i++) {
                      if (orders[i].acknowledged == true) {
                        totalsales += int.parse(orders[i].totalAmount.toString());
                      }
                    }
                    log(totalsales.toString());
          
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber.shade50),
                      height: MediaQuery.sizeOf(context).height * .19,
                      width: double.infinity,
                      child: Row(
                        spacing: 15,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .42,
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/adminicon/business.png")),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.sizeOf(context).width * .39,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Total sales",style: TextStyle(fontSize: 17),),
                                  Text(
                                    totalsales.toString(),
                                    style: TextStyle(
                                        fontSize: 45,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    );
                  }
                  // if(state is Orderssuccess && state.iserror)
                  if(state is OrdersError){
                    return Center(child: Text(state.errormessage.toString()));
                  }
                  
                  return Text('loading');
                },
              ),
              BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
                builder: (context, state) {
                  if (state is AdminDashboardsuccess) {
                    return Column(
                      children: [
                      
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber.shade50),
                          height: MediaQuery.sizeOf(context).height * .276,
                          width:double.infinity,
                          child: Column(
                            children: [
                              Row(
                                // spacing: 10,
                                children: [
                                  InkWell(onTap: () {
                                    
                                    Navigator.push(context, (MaterialPageRoute(builder: (context){
                                      return UsersList();
                                    })));
                                  },
                                    child: Card(
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width * .43,
                                        height:
                                            MediaQuery.sizeOf(context).height * .14,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/adminicon/group.png",
                                              height:    MediaQuery.sizeOf(context).height * .03,
                                              width: 33,
                                            ),
                                            Text(
                                              "Users",
                                              style: TextStyle(fontSize: 19),
                                            ),
                                            Text(
                                              state.dashboardData.usersCount ?? '',
                                              style: TextStyle(fontSize: 29),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(onTap:() {
                                      context.read<ProductBloc>().add(ProductList());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductListScreen();
                          }));
                                  },
                                    child: Card(
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width * .42,
                                        height:
                                            MediaQuery.sizeOf(context).height * .14,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/adminicon/groceries.png",
                                              width: 32,
                                              height:   MediaQuery.sizeOf(context).height * .03 ,
                                            ),
                                            Text(
                                              "Products",
                                              style: TextStyle(fontSize: 19),
                                            ),
                                            Text(
                                              state.dashboardData.productCount ??
                                                  "",
                                              style: TextStyle(fontSize: 29),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(onTap: () {
                                   context.read<ProductBloc>().add(ProductstockGet());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StockoutScreen();
                          }));
                              },
                                child: SizedBox(
                                   height:   MediaQuery.sizeOf(context).height * .1,
                                    width: double.infinity,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/adminicon/stockout.png",
                                              color: Colors.red,
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Stockout: ",
                                              style: TextStyle(fontSize: 19),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              state.dashboardData
                                                      .stockOutProductCount ??
                                                  "",
                                              style: TextStyle(fontSize: 30),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                          Row(
                            children: [SizedBox(width: 10,),
                              
                                InkWell(
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "User Orders",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                      Icon(Icons.chevron_right)
                                    ],
                                  ),
                                  onTap: () { context.read<OrdersBloc>().add(OrdersListGet());
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                 
                              
                                
                                    return AllOrders();
                                  }));
                  },
                                ),
          
                              
                            ],
                          ),
                        SizedBox(height: 8,),
                  ...List.generate(state.dashboardData.allorders.length,(index){
                         final orders = state.dashboardData.allorders??[];
                            DateTime parsedDate = DateTime.parse(orders[index].dateTime);
                  String formattedDate = DateFormat("dd-MM-yy").format(parsedDate);
                         
                         
                             return Padding(
                               padding: const EdgeInsets.only(bottom: 8,top: 8),
                               child: InkWell(onTap: () {
                                  context.read<OrdersBloc>().add(OrdersListGet());
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                 
                              
                                
                                    return AllOrders();
                                  }));
                               },
                                 child: Container(padding: EdgeInsets.all(15),
                                   height: 80,
                                   width: double.infinity,
                                   decoration: BoxDecoration(color: Colors.amber.shade50),
                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                   spacing: 4,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [ 
                                          Text("User id: ${orders[index].userId.toString()} "),
                                           Text(formattedDate),
                                         ],
                                       ), 
                                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [ 
                                          Text("Total: ₹${orders[index].totalAmount.toString()} "),
                                           Text(orders[index].acknowledged==true?'Approved ✔️':'Approve',style: 
                                           TextStyle(color: orders[index].acknowledged==true?Colors.green:Colors.red),),
                                         ],
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             );
                    
                  })
        
                       
          
                      ],
                    );
                  }
                  if (state is AdminDashboardLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is AdminDashboardError) {
                    return Center(child: Text(state.errormessage.toString()));
                  }
                  return Center(child: (Text('please wait or load again')));
                },
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}


  // BlocBuilder<OrdersBloc, OrdersState>(
              
            //   builder: (context, state) {
            //     if(state is OrdersBloc){
            //     return Expanded(
            //       child: LineChart(
            //         LineChartData(
            //             borderData: FlBorderData(show: false),
            //             gridData: FlGridData(show: false),
            //             minX: 0,
            //             minY: 0,
            //             maxX: 7,
            //             maxY: 7,
            //             titlesData: FlTitlesData(
            //                 topTitles: AxisTitles(
            //                     sideTitles: SideTitles(showTitles: false)),
            //                 leftTitles: AxisTitles(
            //                     sideTitles: SideTitles(
            //                         showTitles: false, reservedSize: 12)),
            //                 bottomTitles: AxisTitles(
            //                   sideTitles: SideTitles(showTitles: true),
            //                 ),
            //                 rightTitles: AxisTitles(
            //                     sideTitles: SideTitles(showTitles: false))),
            //             lineBarsData: [
            //               LineChartBarData(
            //                   spots: [
            //                     FlSpot(.4, 1.7),
            //                     FlSpot(0.5, 2),
            //                     FlSpot(1, 3),
            //                     FlSpot(2, 4),
            //                     FlSpot(3, 2),
            //                     FlSpot(4, 4.5),
            //                     FlSpot(5, 5),
            //                     FlSpot(6, 5.6),
            //                     FlSpot(6.5, 4)
            //                   ],
            //                   isCurved: true,
            //                   color: Colors.blueAccent,
            //                   barWidth: 3,
            //                   belowBarData: BarAreaData(
            //                       show: true,
            //                       color: Colors.blue.withOpacity(0.3)))
            //             ],
            //             backgroundColor: Colors.amber.shade50),
            //       ),
            //     );
            //     }
            //     return(CircularProgressIndicator());
            //   },
            // )