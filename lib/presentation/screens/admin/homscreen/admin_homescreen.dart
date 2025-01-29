import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/admin/acknowledge.dart';

import 'package:grocery_app/presentation/screens/admin/orders/all_orders_screen.dart';
import 'package:grocery_app/presentation/screens/admin/product/productList.dart';
import 'package:grocery_app/presentation/screens/admin/product/productcreate.dart';

import 'package:grocery_app/presentation/screens/admin/stockout_screen.dart';
import 'package:grocery_app/presentation/screens/admin/users_list.dart';

class AdminHomescreen extends StatelessWidget {
  const AdminHomescreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(backgroundColor: const Color.fromARGB(255, 252, 250, 245),
    
      drawer: Drawer(
        backgroundColor: Colors.amber.shade50,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                color: Colors.amber.shade200,
              ),
            ),
     
             InkWell(child: ListTile(title: Text("Home"),onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){return AdminHomescreen();})),)),
             Divider(),
             
             InkWell(child: ListTile(title: Text("Orders"),),onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){return AllOrders();}))),     Divider(),
                InkWell(child: ListTile(title: Text("Stock"),onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){return StockoutScreen();}))),
                
                
                
                ),      Divider(),  InkWell(child: ListTile(title: Text("Products"),),onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){return Productlist();}))),     Divider(),
                   InkWell(child: ListTile(title: Text("Product Registration"),),onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){return Productcreate();}))),     Divider(),
                      ListTile(title: Text("Signout"),)
          ],
        ),
      ),
      appBar: AppBar(toolbarHeight: 35,
        backgroundColor: Colors.amber.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          spacing: 14,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UsersList();
                    })),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade200,
                      radius: 35,
                      child: CircleAvatar(foregroundImage: AssetImage("assets/adminicon/team.png"),
                        backgroundColor: Colors.amber.shade50,
                        radius: 33,
                      ),
                    ),
                  ),
                  Text("users")
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AllOrders();
                    })),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade200,
                      radius: 35,
                      child: CircleAvatar(foregroundImage: AssetImage("assets/adminicon/orders.png"),
                        backgroundColor: Colors.amber.shade50,
                        radius: 33,
                      ),
                    ),
                  ),
                  Text("orders")
                ],
              ),
               Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StockoutScreen();
                    })),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade200,
                      radius: 35,
                      child: CircleAvatar(foregroundImage: AssetImage("assets/adminicon/stock.png"),
                        backgroundColor: Colors.amber.shade50,
                        radius: 33,
                      ),
                    ),
                  ),
                  Text("stock")
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Productlist();
                    })),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade200,
                      radius: 35,
                      child: CircleAvatar(foregroundImage: AssetImage("assets/adminicon/cart.png"),
                        backgroundColor: Colors.amber.shade50,
                        radius: 33,
                      ),
                    ),
                  ),
                  Text("products")
                ],
              ),
            ],
                        ),
             Column(
               children: [
                 Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber.shade100),
                    height: MediaQuery.sizeOf(context).height * .19,
                    width: MediaQuery.sizeOf(context).width * .98,
                    child: Row(
                      spacing: 15,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .46,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/adminicon/business.png")),
                                color: Colors.amber.shade50,
                              ),
                            
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * .39,
                            child:
                                
                                Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "1146",
                                      style: TextStyle(fontSize: 45,color: Colors.orange,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              
                            ),
                      ],
                    ),
                  ),
               ],
             ),
        
        
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber.shade200),
                height: MediaQuery.sizeOf(context).height * .276,
                width: MediaQuery.sizeOf(context).width * .98,
                child: Column(
                  children: [
                    Row(
                      // spacing: 10,
                      children: [
                        Card(
                          child: Container(     width: MediaQuery.sizeOf(context).width * .44,
                          height: MediaQuery.sizeOf(context).height*.14,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               Image.asset("assets/adminicon/group.png",height: 31,width: 33,),
                                Text(
                                  "Users",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "140",
                                  style: TextStyle(fontSize: 40),
                                )
                              ],
                            ),
                          ),
                        ),
                      
                          Card(
                          child: Container(     width: MediaQuery.sizeOf(context).width * .44,
                          height: MediaQuery.sizeOf(context).height* .14 ,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/adminicon/groceries.png",width: 33,height: 32,),
                                Text(
                                  "Products",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "1240",
                                  style: TextStyle(fontSize: 40),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                      
                    ),
                 SizedBox(
                                 height: 90,
                                 width: double.infinity,
                                 child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                       
                        color: Colors.amber.shade50,
                      ),
                    child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Acknowledge();
                    })),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/banner/stockout.png",color: Colors.red,
                            height: 39,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Stockout: ",
                            style: TextStyle(fontSize: 21),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "555",
                            style: TextStyle(fontSize: 41),
                          )
                        ],
                      ),
                    ),
                  ),
                                 )),
          ],
                ),
              ),
              Expanded(
                child: LineChart(LineChartData(borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),minX: 0,minY: 0,maxX: 7,maxY: 7,
                titlesData: FlTitlesData(topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles:AxisTitles(sideTitles: SideTitles(showTitles:false,reservedSize: 12)),bottomTitles:AxisTitles(sideTitles: SideTitles(showTitles: true),),rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)) ),
                  lineBarsData: [LineChartBarData(spots: [FlSpot(.4 ,1.7),FlSpot(0.5 ,2),FlSpot(1 ,3),FlSpot(2 ,4),FlSpot(3 ,2),FlSpot(4 ,4.5),FlSpot(5 ,5),FlSpot(6 ,5.6),FlSpot(6.5 ,4)],isCurved: true,color: Colors.blueAccent,barWidth: 3,
                  belowBarData: BarAreaData(show: true,color:Colors.blue.withOpacity(0.3))
                  )],backgroundColor: Colors.amber.shade100),),
              )
           
                 ],
        ),
      ),
    );
  }
}
