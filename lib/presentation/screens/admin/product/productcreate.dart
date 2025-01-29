import 'package:flutter/material.dart';

class Productcreate extends StatelessWidget {
  const Productcreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.amber.shade200,),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(spacing: 20,children: [
        TextFormField(
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
                // controller: namecontroller,
                decoration: InputDecoration(filled: true,fillColor: Colors.amber.shade50,
                    hintText: "Product Name",
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber.shade200),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder()),
              ),
                    TextFormField(
                      maxLines: 5,
                
                    
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
                // controller: namecontroller,
                decoration: InputDecoration(filled: true,fillColor: Colors.amber.shade50,
                    hintText: "Product Description",
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber.shade200),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder()),
              ),     TextFormField(
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
                // controller: namecontroller,
                decoration: InputDecoration(filled: true,fillColor: Colors.amber.shade50,
                    hintText: "Price",
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber.shade200),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder()),
              ),
                    TextFormField(
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
                // controller: namecontroller,
                decoration: InputDecoration(filled: true,fillColor: Colors.amber.shade50,
                    hintText: "Unit",
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber.shade200),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder()),
              ),
                    TextFormField(
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
              // controller: namecontroller,
              decoration: InputDecoration(filled: true,fillColor: Colors.amber.shade50,
                  hintText: "Stock Quantity",
                  hintStyle: TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder()),
            ),
            TextFormField(readOnly: true,
                
                // controller: namecontroller,
                decoration: InputDecoration(filled: true,fillColor: Colors.amber.shade50,
                    hintText: "Image",
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber.shade200),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder()),
              ),
              //     Container(padding: EdgeInsets.only(left: 8),
              // child:InkWell(child: Row(children: [Text("Upload"),Icon(Icons.upload)],)),
              // // controller: namecontroller,
              // decoration: BoxDecoration(color:  Colors.amber.shade50,
              //  border: Border.all(color: Colors.amber.shade200),
              //         borderRadius: BorderRadius.circular(10)),height: 70,
              //  ),
            
                  TextFormField(
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
              // controller: namecontroller,
              decoration: InputDecoration(filled: true,fillColor: Colors.amber.shade50,
                  hintText: "Available?",
                  hintStyle: TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder()),
            ),
        
      ],),
    ),);
  }
}