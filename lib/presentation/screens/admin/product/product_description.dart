// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class AdminProductDescription extends StatelessWidget {
  String? imgpath;
  String? description;
  String? producName;
  String? price;
  String? stockQuantity;
  String? unit;

  AdminProductDescription(
      {super.key,
      this.imgpath,
      this.description,
      this.producName,
      this.price,
      this.stockQuantity,
      this.unit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    image: DecorationImage(fit: BoxFit.cover,
                      image: AssetImage(imgpath ?? ""),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.3,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black38, width: 3),
                    color: Colors.amber.shade50),
                padding: EdgeInsets.all(8),
                child: Column(
                  spacing: 35,
                  children: [
                    Row(children: [
                      Text("Product Name:"),
                      Spacer(),
                      Text(producName ?? "")
                    ]),
                    Row(children: [
                      Text("description:"),
                      Spacer(),
                      Text(description ?? "")
                    ]),
                    Row(children: [
                      Text("Price:"),
                      Spacer(),
                      Text(price ?? "")
                    ]),
                    Row(children: [Text("Unit:"), Spacer(), Text(unit ?? "")]),
                    Row(children: [
                      Text("Stock Quantity:"),
                      Spacer(),
                      Text(stockQuantity ?? "")
                    ])
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
