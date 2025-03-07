import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/category/model/category_model.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/category/add_Category.dart';

class Getallcategory extends StatefulWidget {
  const Getallcategory({super.key});

  @override
  State<Getallcategory> createState() => _GetallcategoryState();
}

class _GetallcategoryState extends State<Getallcategory> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Addcategory(buttonMode: CategoryAddButtonMode.add);
          }));
        },
        backgroundColor: Colors.amber.shade200,
        hoverColor: Colors.white,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryLoaded &&
              state.message == 'Category updated successfully') {
            context.read<CategoryBloc>().add(
                CategoryGet()); 
            log('category updated');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Category updated successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is CategoryLoaded &&
              state.message == 'Deleted successfully') {
            context
                .read<CategoryBloc>()
                .add(CategoryGet());
            log('category deleted');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Category deleted successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is CategoryLoaded && state.message == 'successful') {
            context
                .read<CategoryBloc>()
                .add(CategoryGet());
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
          if(state is CategoryLoading){
            return Center(child: CircularProgressIndicator(),);
          }

          if (state is CategoryLoaded && state.isLoading == true) {
            log('message');
            List<CategoryModel>? categories = state.categoryList;
            return Stack(
              children: [
                GridView.builder(
                    itemCount: categories!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent:
                            MediaQuery.sizeOf(context).height * 0.099,
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
                              Expanded(
                                  flex: 10,
                                  child: Text(
                                    categories[index].name,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  )),
                              Spacer(),
                              PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      onTap: () => Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        final categoryName =
                                            categories[index].name;
                                        final id = categories[index].id;

                                        return Addcategory(
                                          buttonMode:
                                              CategoryAddButtonMode.edit,
                                          categoryToEdit: categoryName,
                                          id: id,
                                        );
                                      })),
                                      value: "Option1",
                                      child: Text("Edit"),
                                    ),
                                    PopupMenuItem<String>(
                                      onTap: () {
                                        final id = categories[index].id;
                                        context
                                            .read<CategoryBloc>()
                                            .add(CategoryDelete(id: id));
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
                SizedBox(height: double.infinity,width: double.infinity,
                  child: Center(child: CircularProgressIndicator()))
              ],
            );
          }

          if (state is CategoryLoaded && (state.categoryList?.isNotEmpty??false)) {
            log('categoryLoaded');
            List<CategoryModel>? categories = state.categoryList ?? [];
            return GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: MediaQuery.sizeOf(context).height * 0.099,
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.amber.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        spacing: 10,
                        children: [
                          Expanded(
                              flex: 10,
                              child: Text(
                                categories[index].name,
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              )),
                          Spacer(),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    final categoryName = categories[index].name;
                                    final id = categories[index].id;

                                    return Addcategory(
                                      buttonMode: CategoryAddButtonMode.edit,
                                      categoryToEdit: categoryName,
                                      id: id,
                                    );
                                  })),
                                  value: "Option1",
                                  child: Text("Edit"),
                                ),
                                PopupMenuItem<String>(
                                  onTap: () {
                                    final id = categories[index].id;
                                    context
                                        .read<CategoryBloc>()
                                        .add(CategoryDelete(id: id));
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

        
          if (state is CategoryLoaded && state.isError == true) {
            log('CategoryLoaded && state.isLoading==true');
            return Center(
              child: Text(state.errorMsg.toString()),
            );
          }

          if (state is CategoryError) {
            log(state.msg, name: 'CategoryError while getting all Catgeory');
            return Center(
              child: Text(state.msg),
            );
          }
          return Center(child: Text("Loading"));
        },
      ),
    );
  }
}
