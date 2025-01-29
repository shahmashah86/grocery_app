import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/user/order_placed/order_placed.dart';





class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: ListView(padding: EdgeInsets.only(left: 10, right: 10), children: [
        SizedBox(
          height: 10,
        ),
        Card(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: BoxDecoration(
                // color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(20)),
            width: double.infinity,
            child: Row(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 9,),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * .18,
                    width: MediaQuery.sizeOf(context).width * .37,
                    decoration: BoxDecoration(
             
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/blueberries.jpg"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, ),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BlueBerry",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                   
                         Text(
                        "₹400",
                        style: TextStyle(fontSize: 17),
                      ),
                     
                     Row(
                          spacing: 2,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber.shade300),
                                width:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                child: IconButton(
                                    padding: EdgeInsets.all(3),
                                    onPressed: () {
                                     
                                    },
                                    icon: Icon(Icons.remove,size: 20,))),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width:
                                    MediaQuery.sizeOf(context).height * 0.04,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.04,
                                child: Center(
                                    child: Text(
                                  "3Kg",
                                  style: TextStyle(fontSize: 15),
                                ))),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber.shade300),
                                width:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                child: IconButton(
                                    padding: EdgeInsets.all(3),
                                    onPressed: () {
                                      // quantity.value = quantity.value + 1;
                                    
                                    },
                                    icon: Icon(Icons.add,size: 20,)))
                          ],
                          
                                                 ),
                    
                     
                    ],
                  ),
            
                ),Spacer(),
                   IconButton(padding: EdgeInsets.only(right: 9),
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete_outline,
                                                size: 30,
                                                color: Colors.black54,
                                              )),
                
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
         Card(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: BoxDecoration(
                // color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(20)),
            width: double.infinity,
            child: Row(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * .18,
                    width: MediaQuery.sizeOf(context).width * .37,
                    decoration: BoxDecoration(
             
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/blueberries.jpg"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, ),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BlueBerry",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                   
                         Text(
                        "₹400",
                        style: TextStyle(fontSize: 17),
                      ),
                     
                     Row(
                          spacing: 2,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber.shade300),
                                width:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                child: IconButton(
                                    padding: EdgeInsets.all(3),
                                    onPressed: () {
                                     
                                    },
                                    icon: Icon(Icons.remove,size: 20,))),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width:
                                    MediaQuery.sizeOf(context).height * 0.04,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.04,
                                child: Center(
                                    child: Text(
                                  "3Kg",
                                  style: TextStyle(fontSize: 15),
                                ))),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber.shade300),
                                width:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.035,
                                child: IconButton(
                                    padding: EdgeInsets.all(3),
                                    onPressed: () {
                                      // quantity.value = quantity.value + 1;
                                    
                                    },
                                    icon: Icon(Icons.add,size: 20,)))
                          ],
                          
                                                 ),
                    
                     
                    ],
                  ),
            
                ),Spacer(),
                   IconButton(padding: EdgeInsets.only(right: 9),
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete_outline,
                                                size: 30,
                                                color: Colors.black54,
                                              )),
                
              ],
            ),
          ),
        ),
      
        SizedBox(
          height: 10,
        ),
        Card(
            child: Container(
          height: MediaQuery.sizeOf(context).height * 0.27,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Payment Summary",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
                Divider(color: Colors.black12),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(
                        "Sub Total:",
                        style: TextStyle(fontSize: 14,color: Colors.black54),
                      ),
                      Spacer(),
                      Text("₹330", style: TextStyle(fontSize: 18,)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        "Delivery Fee:",
                        style: TextStyle(fontSize: 14,color: Colors.black54),
                      ),
                      Spacer(),
                      Text("Free", style: TextStyle(fontSize: 18,)),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(fontSize: 15,),
                      ),
                      Spacer(),
                      Text("₹230", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
        SizedBox(
          height: 6,
        ),
        TextButton(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
                backgroundColor: WidgetStatePropertyAll(Colors.amber.shade300)),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context){return OrderPlaced();}));},
            child: Center(
                child: Text(
              "Place Order",
              style: TextStyle(fontSize: 20),
            )))
      ]),
    );
  }
}
