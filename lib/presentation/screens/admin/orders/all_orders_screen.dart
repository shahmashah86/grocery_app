import 'package:flutter/material.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> orderdetails = [
      {
        "id": "1",
        "date": "2025-01-02",
        "totalitems": "5",
        "totalAmount": "30",
        "userid":"444"
      },
      {
        "id": "2",
        "date": "2025-01-02",
        "totalitems": "5",
        "totalAmount": "30",
            "userid":"454"
      },
      {
        "id": "3",
        "date": "2025-01-02",
        "totalitems": "5",
        "totalAmount": "30",
            "userid":"124"
      },
      {
        "id": "4",
        "date": "2025-01-02",
        "totalitems": "3",
        "totalAmount": "30",
            "userid":"30"
      },
   
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Order List",),leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_left,size: 32)),
        backgroundColor: Colors.amber.shade200,
      ),
      body: ListView.builder(
        itemCount: orderdetails.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left:8,right: 8,top: 8,bottom: 10),
            child: Card(
              child: Container(padding: EdgeInsets.only(left: 8,right: 9),
                height: MediaQuery.sizeOf(context).height * 0.25,
                decoration: BoxDecoration(color:const Color.fromARGB(255, 251, 247, 233),
                 borderRadius: BorderRadius.circular(10),
          
                    ),
                width: double.infinity,
                child: Column(
                  children: [

              Row(children: [Text("2",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),)],),
                   Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("User Id",style: TextStyle(color: Colors.black54),),Spacer(),
                                  Text(
                                                          orderdetails[index]["userid"]!,
                                                            style: TextStyle(fontSize: 20,),
                                                          ),
                                ],
                              ),Divider(thickness: .5),
                               Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Total Items",style: TextStyle(color: Colors.black54)),Spacer(),
                                  Text(
                                                          orderdetails[index]["totalitems"]!,
                                                            style: TextStyle(fontSize: 20,),
                                                          ),
                                ],
                              ),Divider(thickness: .5),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Total Amount",style: TextStyle(color: Colors.black54)),Spacer(),
                                  Text(
                                                          orderdetails[index]["totalAmount"]!,
                                                            style: TextStyle(fontSize: 20,),
                                                          ),
                                ],
                              ),Divider(thickness: .5,),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Date",style: TextStyle(color: Colors.black54)),Spacer(),
                                  Text(
                                                          orderdetails[index]["date"]!,
                                                            style: TextStyle(fontSize: 20,),
                                                          ),
                                ],
                              ),
               
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
