// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';

class Addcategory extends StatefulWidget {
  final String? categoryToEdit;
   final CategoryAddButtonMode buttonMode;
   final int? id;
  const Addcategory({
    Key? key,
    this.categoryToEdit,
    required this.buttonMode,  this.id,
  }) : super(key: key);


  @override
  State<Addcategory> createState() => _AddcategoryState();

}

class _AddcategoryState extends State<Addcategory> {
     late TextEditingController categoryController;
    
    
  @override
  void initState() {
     categoryController = TextEditingController();
    if(widget.categoryToEdit!=null){
      widget.buttonMode==CategoryAddButtonMode.edit;
      
   
      categoryController.text=widget.categoryToEdit??'';
      
    }
    log(categoryController.text,name: 'categoryToEdit or empty');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
 
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 5,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber.shade50,
                    border: Border.all()),
                height: MediaQuery.sizeOf(context).height * 0.2,
                child: TextFormField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                    ))),
            TextButton(
              onPressed: () {
                if(widget.buttonMode==CategoryAddButtonMode.edit){
                    final categoryName=categoryController.text.trim();
                context.read<CategoryBloc>().add(CategoryUpdate(categoryName: categoryName,id:widget.id! ));
                log(categoryName);
                log(widget.id.toString());
             

                }
            else{
                    final categoryName=categoryController.text.trim();
                context.read<CategoryBloc>().add(CategoryCreate(categeoryName: categoryName));

            }

                   Navigator.pop(context);
              



              },
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: WidgetStatePropertyAll(Colors.amberAccent)),
              child: Center(
                child: Text(
                widget.buttonMode==CategoryAddButtonMode.edit?'Edit':'submit'
                


              
              )
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum CategoryAddButtonMode{add,edit}