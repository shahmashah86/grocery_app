import 'package:flutter/material.dart';

import 'package:grocery_app/presentation/screens/admin/product/product_description.dart';

class Productlist extends StatelessWidget {
  const Productlist({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> productdetails = [
      {
        "Product Name": "Apple",
        "Price": "121",
        "Unit": "kg",
        "stockQuantity": "30",
        "Image": "assets/images/blueberries.jpg",
        "description": "Fresh Fruit",
    
      },
      {
        "Product Name": "toamto",
        "Price": "121",
        "Unit": "kg",
        "stockQuantity": "30",
        "Image": "assets/images/tomato.jpeg",
        "description": "Fresh Fruit"
      },
      {
        "Product Name": "Strawberry",
        "Price": "121",
        "Unit": "kg",
        "stockQuantity": "30",
        "Image": "assets/images/strawberry.jpeg",
        "description": "Fresh Fruit"
      },
      {
        "Product Name": "Apple",
        "Price": "121",
        "Unit": "kg",
        "stockQuantity": "30",
        "Image": "assets/images/tomato.jpeg",
        "description": "Fresh Fruit"
      },
      {
        "Product Name": "Apple",
        "Price": "121",
        "Unit": "kg",
        "stockQuantity": "30",
        "Image": "assets/images/tomato.jpeg",
        "description": "Fresh Fruit"
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: ListView.builder(
        itemCount: productdetails.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AdminProductDescription(
                  imgpath: productdetails[index]["Image"],
                  description: productdetails[index]["description"],
                  price: productdetails[index]["Price"],
                  producName: productdetails[index]["Product Name"],
                  stockQuantity: productdetails[index]["stockQuantity"],
                  unit: productdetails[index]["Unit"],
                );
              })),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.amber.shade100,
                      Colors.amber.shade50,
                      Colors.amber.shade100,
                    ], stops: [
                      0.1,
                      0.5,
                      0.8
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.lime)),
                width: double.infinity,
                child: Row(
                  spacing: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,right: 4
                      ),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * .18,
                        width: MediaQuery.sizeOf(context).width * .37,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(productdetails[index]["Image"]!),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productdetails[index]["Product Name"]!,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Price:${productdetails[index]["Price"]!}",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Unit: ${productdetails[index]["Unit"]!}",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: "Option1",
                            child: Text("Edit"),
                          ),
                          PopupMenuItem<String>(
                            value: "Option2",
                            child: Text(
                              "Delete",
                            ),
                          )
                        ];
                      },
                      icon: Icon(Icons.more_vert),
                    )
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
