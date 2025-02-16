

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/admin/common/category/model/category_model.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/category/addCategory.dart';

class Getallcategory extends StatefulWidget {
  const Getallcategory({super.key});

  @override
  State<Getallcategory> createState() => _GetallcategoryState();
}

class _GetallcategoryState extends State<Getallcategory> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryGet());
      // Future.delayed(Duration(seconds: 2),(){
      //       // SpinKitThreeBounce(size: 20,color:  Color.fromARGB(255, 220, 215, 215),);

      // });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> Items = [
      {'id': 1, "name": "Food"},
      {'id': 2, "name": "Foods"},
      {'id': 3, "name": "Foodss"},
      {'id': 3, "name": "Foodss"},
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Addcategory(buttonMode:  CategoryAddButtonMode.add);
          }));
        },
        child: Icon(Icons.add),
        backgroundColor:  Colors.amber.shade200,
        hoverColor: Colors.white,
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if(state is CategoryLoaded&& state.message=='Category updated successfully'){
              context.read<CategoryBloc>().add(CategoryGet());/////////////////////////////////ingne event idak call chythoode
          log('category updated');
          ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Category updated successfully!'),
    duration: Duration(seconds: 2),
  ),
);
          }

             else if(state is CategoryLoaded&& state.message=='Deleted successfully'){
              context.read<CategoryBloc>().add(CategoryGet());/////////////////////////////////
          log('category deleted');
          ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Category deleted successfully!'),
    duration: Duration(seconds: 2),
  ),
);
          }
                   else if(state is CategoryLoaded&& state.message=='successful'){
              context.read<CategoryBloc>().add(CategoryGet());/////////////////////////////////
          log('category created');
          ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Category created successfully!'),
    duration: Duration(seconds: 2),
  ),
);
          }



        },
        builder: (context, state) {
                 
          //////////idh epola work aaava
          if(state is CategoryLoaded && state.isLoading==true){
            log('message');
                List<CategoryModel>? categories=state.categoryList;
            return Stack(children: [
                 GridView.builder(
              itemCount: categories!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: MediaQuery.sizeOf(context).height * 0.099,
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.amberAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(flex: 10,child: Text(categories[index].name,style: TextStyle(overflow: TextOverflow.ellipsis),)),
                        Spacer(),

                        PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(onTap: () => 
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                final categoryName = categories[index].name;
                                final id=categories[index].id;

                                return Addcategory(buttonMode: CategoryAddButtonMode.edit,
                                    categoryToEdit: categoryName,id: id,);
                              })),
                            value: "Option1",
                            child: Text("Edit"),
                          ),
                          PopupMenuItem<String>(
                            onTap: () {
                                 final id=categories[index].id;
context.read<CategoryBloc>().add(CategoryDelete(id:id ));
                            },
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
                );
              }),
            
                 
              SpinKitThreeBounce(size: 20,color:  Color.fromARGB(255, 220, 215, 215),)
              



            ],


            );
          }

    



          if(state is CategoryLoaded){
            log('categoryLoaded');
            List<CategoryModel>? categories=state.categoryList??[];
              return GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: MediaQuery.sizeOf(context).height * 0.099,
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.amberAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(flex: 10,child: Text(categories[index].name,style: TextStyle(overflow: TextOverflow.ellipsis),)),
                        Spacer(),

                        PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(onTap: () => 
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                final categoryName = categories[index].name;
                                final id=categories[index].id;

                                return Addcategory(buttonMode: CategoryAddButtonMode.edit,
                                    categoryToEdit: categoryName,id: id,);
                              })),
                            value: "Option1",
                            child: Text("Edit"),
                          ),
                          PopupMenuItem<String>(
                            onTap: () {
                                 final id=categories[index].id;
context.read<CategoryBloc>().add(CategoryDelete(id:id ));
                            },
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
                );
              });

          }
       
          
          ///////
 if(state is CategoryLoaded && state.isError==true){
            log('CategoryLoaded && state.isLoading==true');
           return Center(child: Text('Something is wrong!'),);
           
          }




        if(state is CategoryError){
          log(state.msg,name: 'CategoryError while getting all Catgeory');
          return Center(child: Text(state.msg),);

        }
          return SpinKitThreeBounce(color: Colors.amberAccent,);
             
        },
      ),
    
    );
  }
}
