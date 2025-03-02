import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/screens/user/cart/cart.dart';
import 'package:grocery_app/presentation/screens/user/homeScreen/homescreen.dart';
import 'package:grocery_app/presentation/screens/user/pdoduct_description/product_description.dart';

class Searchscreen extends StatefulWidget {
  final bool searchfromDashboard;
  const Searchscreen({super.key, required this.searchfromDashboard});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  ValueNotifier<int> cartitemsCount = ValueNotifier(0);
  late final TextEditingController searchController;

  @override
  void initState() {
    context.read<CartBloc>().add(CartitemsGet());
    searchController = TextEditingController();
    super.initState();

    if (widget.searchfromDashboard == false) {
      context.read<ProductBloc>().add(ProductList());
    }
  }

  @override
  void dispose() {
    log(widget.searchfromDashboard.toString());
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(        leading: IconButton(onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: 
            (context){
              return HomeScreen();
            }), (route)=>false);
            
          }, icon: Icon(Icons.arrow_back)),
          title: Text("Search",style: TextStyle(fontWeight: FontWeight.w500),),
            expandedHeight: 170,
            floating: false,
            backgroundColor: Colors.amber.shade200,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ValueListenableBuilder(
                  valueListenable: cartitemsCount,
                  builder: (context, value, child) =>
                      BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Cart()),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              'assets/user/shoppingcart.png',
                              height: MediaQuery.sizeOf(context).height * .044,
                            ),
                            Positioned(
                              right: -6,
                              top: -6,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.amber,
                                child: BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                      if(state is CartLoaded){
                                    return Text(
                                        state.cartItems?.length.toString() ??
                                            '0');
                                  }
                                   return Text(
                                         
                                            '0');
                                  }
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                      
                    },
                  ),
                ),
              ),
            ],
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double percent = (constraints.maxHeight - kToolbarHeight) /
                    (150 - kToolbarHeight);
                percent = percent.clamp(0.0, 1.0);
                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(bottom: 10),
                  title: percent > 0.3
                      ? Opacity(
                          opacity: percent,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Fresh Picks, Fast Delivery! 🍎🛒",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
          // ✅ Pass the TextEditingController from _SearchscreenState
          if (!widget.searchfromDashboard)
            SliverPersistentHeader(
              pinned: true,
              delegate: SearchBarDelegate(searchController),
            ),

          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * .5,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              if (state is ProductLoaded) {
                if (state.isLoading) {
                  if (state.frombottomnav) {
                    log('loading');

                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * .5,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                  if (state.frombottomnav == false) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * .5,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                }

                if (state.isError == true) {
                  log('errror  from screen', name: 'error from searchscreen');
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * .5,
                      child: Center(child: Text(state.errormsg.toString())),
                    ),
                  );
                }

                if (state.searchList?.isEmpty??true) {
                  return SliverToBoxAdapter(
                    child: Padding(padding: EdgeInsets.symmetric(
                         vertical:     MediaQuery.sizeOf(context).height * .12,
                         
                  
                    ),
                      child:Column(
                        children: [
                          Text(
                            "Oops!!..no result for your search",
                            style:
                                TextStyle(fontSize: 23, color: Colors.black38),
                          ),
                          Image.asset('assets/user/notFound.png',
                              height: MediaQuery.sizeOf(context).height * .3,
                              width: MediaQuery.sizeOf(context).width * .85),
                        ],
                      ),
                      
                    ),
                  );
                }

                if ((state.productList?.isEmpty ?? true) &&
                    state.frombottomnav) {
                  return SliverToBoxAdapter(child: Text('data'));
                }
                if ((state.productList?.isNotEmpty ?? false) &&
                    state.frombottomnav) {
                  List<ProductRegModel> productList = state.productList ?? [];
                  return SliverPadding(
                    padding: EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    imageUrl:
                                        productList[index].products.image ?? '',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 60,
                                      color: Colors.black45,
                                    ),
                                    placeholder: (context, url) => SpinKitPulse(
                                      color: Colors.white,
                                    ),
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
                                                productList[index]
                                                        .products
                                                        .productName ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                productList[index]
                                                        .products
                                                        .productDescription ??
                                                    '',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                  "Price: ${productList[index].products.price ?? ''}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          CartModel cartItems = CartModel(
                                            id: productList[index]
                                                    .products
                                                    .id ??
                                                0,
                                            prodName: productList[index]
                                                    .products
                                                    .productName ??
                                                '',
                                            price: productList[index]
                                                    .products
                                                    .price ??
                                                0,
                                            url: productList[index]
                                                    .products
                                                    .image ??
                                                '',
                                          );

                                          bool itemExists = cartBox.values.any(
                                              (item) =>
                                                  item.id == cartItems.id);

                                          if (!itemExists) {
                                            context.read<CartBloc>().add(
                                                CartItemAdd(
                                                    cartItems: cartItems));
                                            cartitemsCount.value =
                                                cartitemsCount.value + 1;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Text(
                                                    "Product added to cart!"),
                                                duration: Duration(seconds: 1),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Text(
                                                  "Product already in cart!",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                duration: Duration(seconds: 1),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
                                        },
                                        icon: Icon(Icons.shopping_cart),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap:() {
                              Navigator.push(context,MaterialPageRoute(builder: (context){
                                return ProductDescription();
                              }));
                              

                              context.read<ProductBloc>().add(Productget(productId: productList[index].products.id!));
                            }
                          );
                        },
                        childCount: productList.length,
                      ),
                    ),
                  );
                }

                if (state.searchList!.isNotEmpty &&
                    state.frombottomnav == false) {
                  List<ProductsModel>? searchList = state.searchList;
                  return SliverPadding(
                    padding: EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context){
                              return ProductDescription();
                            }));

                             context.read<ProductBloc>().add(Productget(productId: searchList![index].id!));
                          },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    imageUrl: searchList?[index].image ?? '',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 60,
                                      color: Colors.black45,
                                    ),
                                    placeholder: (context, url) => SpinKitPulse(
                                      color: Colors.white,
                                    ),
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
                                                searchList?[index]
                                                        .productName ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                searchList?[index]
                                                        .productDescription ??
                                                    '',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                  "Price: ${searchList?[index].price ?? ''}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          CartModel cartItems = CartModel(
                                            id: searchList?[index].id ?? 0,
                                            prodName: searchList?[index]
                                                    .productName ??
                                                '',
                                            price:
                                                searchList?[index].price ?? 0,
                                            url: searchList?[index].image ?? '',
                                          );

                                          bool itemExists = cartBox.values.any(
                                              (item) =>
                                                  item.id == cartItems.id);

                                          if (!itemExists) {
                                            context.read<CartBloc>().add(
                                                CartItemAdd(
                                                    cartItems: cartItems));
                                            cartitemsCount.value =
                                                cartitemsCount.value + 1;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Text(
                                                    "Product added to cart!"),
                                                duration: Duration(seconds: 1),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Text(
                                                  "Product already in cart!",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                duration: Duration(seconds: 1),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
                                        },
                                        icon: Icon(Icons.shopping_cart),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: searchList?.length ?? 0,
                      ),
                    ),
                  );
                }
              }

              if (state is ProductError) {
                log('errror  from screen',
                    name: 'error from searchscreen pr producterror');
                return SliverToBoxAdapter(
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * .5,
                        child: Center(
                            child: Text(
                          state.msg.toString(),
                        ))));
              }

              return SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                    child: Text('Please wait or try again'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Now, SearchBarDelegate receives the controller from the parent widget
class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;

  SearchBarDelegate(this.searchController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: Colors.amber.shade200,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search, color: Colors.black54),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          onSubmitted: (value) {
            if (searchController.text.trim().isNotEmpty) {
              context.read<ProductBloc>().add(
                  Productsearch(productName: searchController.text.trim()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: Text(
                    "enter any products to search",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
