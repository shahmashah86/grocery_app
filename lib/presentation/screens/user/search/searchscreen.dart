import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';

import 'package:grocery_app/presentation/screens/user/pdoduct_description/product_description.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {

  late final TextEditingController searchController;
  @override
  void initState() {
  
     searchController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   
   

    return Scaffold(
      appBar: AppBar(
    
        toolbarHeight:10 ,
        // backgroundColor: Colors.amber.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            CircleAvatar(radius: 26,backgroundColor: Colors.amber.shade200,child: IconButton(onPressed: (){
              Navigator.pop(context);
        
          }, icon: Icon(Icons.chevron_left,size:35 ,)),),
          Text("Fresh Picks, Fast Delivery! 🍎🛒",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.indigo),),
        
                        SizedBox(
                          height: 56,
                          child: SearchBar(controller: searchController,
                            leading: Icon(Icons.search),
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.amber.shade200),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            hintText: 'search',
                            onSubmitted: (value){ 
                              context.read<ProductBloc>().add(Productsearch(productName: searchController.text.trim()));
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Searchscreen();
                            }));},
                          ),
                        ),
            
            Expanded(
         
        
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
  return Center(child: CircleAvatar(child: CircularProgressIndicator()));
}
                  if(state is ProductLoaded && state.isLoading==true){

                       return Center(child: CircleAvatar(child: CircularProgressIndicator(),));
                  }
                   if(state is ProductLoaded && state.searchList!.isEmpty){

                    log("inside empty search",name: 'from searchscreen');
                    return 
                        Column(crossAxisAlignment: CrossAxisAlignment.start,spacing:MediaQuery.sizeOf(context).height*.13,
                          children: [
                      
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Oops!!..sad no results",style: TextStyle(fontSize: 27,color: Colors.black38),),
                            ),
                             Center(child: Image.asset('assets/notfound/notFound3.png',height:MediaQuery.sizeOf(context).height*.3,
                             width:MediaQuery.sizeOf(context).width*.85))
                          ],
                        );
                       
                    
    

                  }
                  if(state is ProductLoaded){
                    List<ProductsModel>? searchList=state.searchList;
                                 return StaggeredGridView.countBuilder(
                    // padding: EdgeInsets.only(left: 8, right: 8),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        // onTap: () => Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return ProductDescription(
                        //     description: searchList[index]['description'],
                        //     imgpath: searchList[index]['image'],
                        //     producName: searchList[index]['Text'],
                        //     price: searchList[index]['Price'],
                        //   );
                        // })),
                        child: Container(
                        
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            CachedNetworkImage(height: MediaQuery.sizeOf(context).height*.23,
                              imageUrl: searchList?[index].image??'',fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                placeholder: (context, url) =>
                                              SpinKitPulse(color: Colors.white,),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 4, top: 4),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            searchList?[index].productName??'',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                          Text(searchList?[index].productDescription??'',
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              "Price:${searchList?[index].price??''}")
                                        ]),
                                  ),
                                ),
                                // Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.shopping_cart)),
                              ],
                            )
                          ]),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    itemCount: searchList?.length??0,
                  );
        
                  }
                 
                  return Text("Please wait or try again"
                   
                  );
                },
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(),
    );
  }
}
