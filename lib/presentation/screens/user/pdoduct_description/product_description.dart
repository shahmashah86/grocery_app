// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class ProductDescription extends StatelessWidget {
  String? imgpath;
  String? description;
  String? producName;
  String? price;

  ProductDescription({
    Key? key,
     this.imgpath,
   this.description,
     this.producName,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imgpath??""), fit: BoxFit.cover),
            color: Colors.amber.shade100,
          ),
          height: MediaQuery.of(context).size.height * 0.48,
          width: double.infinity,
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: const Color.fromARGB(255, 255, 239, 192),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                  child: Column(
                    spacing: 13,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            producName??"",
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            price??"",
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                      Text(
                        description??"",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Text('Quantity',
                              style: TextStyle(
                                fontSize: 25,
                              )),
                          Spacer(),
                          Quantity()
                        ],
                      ),SizedBox(height: 5,),
                      Container(height:50 ,
                        child: TextButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.amber)),
                            onPressed: () {},
                            child: Center(child: Text("Add to Cart",style: TextStyle(fontSize: 18),))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class Quantity extends StatelessWidget {
   Quantity({super.key});
  



final ValueNotifier<int> quantity=ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: quantity,
    builder: (context, value, child) => 
       Row(
                              spacing: 3,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber),
                                    width:
                                        MediaQuery.sizeOf(context).height * 0.04,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.04,
                                    child: IconButton(
                                        padding: EdgeInsets.all(3),
                                        onPressed: () {
                                          if (quantity.value==0){
                                            quantity.value=0;
      
                                          }
                                          else{
                                          quantity.value = quantity.value - 1;
                                          }
                                        
                                        },
                                        icon: Icon(Icons.remove))),
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
                                      "${quantity.value.toString()}Kg",
                                      style: TextStyle(fontSize: 17),
                                    ))),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber),
                                    width:
                                        MediaQuery.sizeOf(context).height * 0.04,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.04,
                                    child: IconButton(
                                        padding: EdgeInsets.all(3),
                                        onPressed: () {
                                          quantity.value = quantity.value + 1;
                                        
                                        },
                                        icon: Icon(Icons.add)))
                              ],
                          ),
    );
  }
}