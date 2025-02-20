import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/data/databases/entity/cart_entity.dart';


import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/screens/user/pdoduct_description/product_description.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key, this.categoryName});
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          title: Text(
            "choose from $categoryName",
            style: TextStyle(fontSize: 27,color: Colors.indigo,fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: CircleAvatar(
                backgroundColor: Colors.amberAccent,
                child: Icon(Icons.chevron_left),
              )),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if(state is CategoryLoading){
              return Center(child: CircularProgressIndicator());

            }
            if(state is CategoryLoaded && state.isLoading==true){
              return Center(child: CircularProgressIndicator(),);
            }

            if (state is CategoryLoaded) {
               List<ProductsModel>? categorywiseProducts=state.produnderCategory;
              return StaggeredGridView.countBuilder(
                padding: EdgeInsets.only(left: 8, right: 8),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  
                 
                  return InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductDescription(
                        description:categorywiseProducts?[index].productDescription??'',
                        imgpath:categorywiseProducts?[index].image??"",
                        producName: categorywiseProducts?[index].productName??"",
                        price: categorywiseProducts?[index].price.toString()??""

                      );
                    }
                    )),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: CachedNetworkImage(fit: BoxFit.cover,
                          placeholder:(context, url) => SpinKitPulse(color: Colors.white,) ,
                              imageUrl:
                              
                                  categorywiseProducts?[index].image??"",
                                       errorWidget: (context, url, error) => Icon(Icons.error,size: 50,color: Colors.black38,),),
                                  
                                  
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
                                      categorywiseProducts?[index]
                                                .productName ??"",
                                          
                                        // searchList[index]['Text'],
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      Text(
                                          categorywiseProducts?[index]
                                                  .productDescription ??
                                              "",
                                          overflow: TextOverflow.ellipsis),
                                      Text(categorywiseProducts?[index].price
                                          .toString()??"")
                                    ]),
                              ),
                            ),
                            // Spacer(),
                            IconButton(
                                onPressed: () {
                                
                                
                              CartModel cartItems=CartModel(id: categorywiseProducts?[index].id??0, prodName: categorywiseProducts?[index].productName??'', price: categorywiseProducts?[index].price??0, url: categorywiseProducts?[index].image??'');

                               bool itemExists = cartBox.values.any(
                                            (item) => item.id == cartItems.id);

                                        if (!itemExists) {
                                      
                                       context.read<CartBloc>().add(CartItemAdd(cartItems: cartItems));
                                        

                                       

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          content: Text(
                                            "Product added to cart!",
                                          ),
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          // backgroundColor: Colors.lime.shade500
                                        ));


                                        }
                                        else{
                                           ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          content: Text(style: TextStyle(color: Colors.red),
                                            "Product already in cart!",
                                          ),
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          // backgroundColor: Colors.lime.shade500
                                        ));

                                        }


                                       
                                },
                                icon: Icon(Icons.shopping_cart)),
                          ],
                        )
                      ]),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                 itemCount: categorywiseProducts?.length??0,
              );
            }
            if(state is CategoryError){
              return Center(child: Text(state.msg));
            }
            return Center(child: Text("Please wait or try again"));
          },
        ));
  }
}
