import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';

import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/screens/user/cart/cart.dart';
import 'package:grocery_app/presentation/screens/user/widgets/product_grid.dart';

class Searchscreen extends StatefulWidget {
  final bool searchfromDashboard;
  const Searchscreen({super.key, required this.searchfromDashboard});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    //cart items getting initailly for finding the count of cart items
    context.read<CartBloc>().add(CartitemsGet());
    searchController = TextEditingController();
    super.initState();

//checking whether entering this page via bottomnav search icon from homescreen or by searchbar searching
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
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height*.16,
            floating: false,
            backgroundColor: Colors.amber.shade200,
            actions: [
              //cart icon on the appbar
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart()),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                                backgroundColor: Colors.amber.shade50,
                                child: BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                  if (state is CartLoaded) {
                                    return Text(
                                        state.cartItems?.length.toString() ??
                                            '0');
                                  }
                                  return Text('0');
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            pinned: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.amber.shade500, Colors.amber.shade100],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double percent = (constraints.maxHeight - kToolbarHeight) /
                      (150 - kToolbarHeight);
                  percent = percent.clamp(0.0, 1.0);
                  return FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(bottom: 10),
                    title: percent > 0.4
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
          ),
          //cheking that entering this screen is from homescreen searchbar if no only make the search bar pinned
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
                  log('inside error', name: 'search screeen');
                  if (state.errormsg ==
                      'Exception: Please provide a product name to search') {
                    log(state.frombottomnav.toString());
                    // List<ProductsModel>? productList =
                    //     (state.productList as List<ProductRegodel>)
                    //         .map((item) => item.products)
                    //         .toList();

                    List<ProductRegModel> allProducts =state. productList!
                        .where((product) => product.products.isAvailable == true)
                        .toList();
                    ProductGrid(
                      productdetail: allProducts,
                      bySearch: false,
                    );
                    log(allProducts.toString(),
                        name: 'allproducts from searchscreen');
                  } else {
                    log('errror  from screen', name: 'error from searchscreen');
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * .5,
                        child: Center(child: Text(state.errormsg.toString())),
                      ),
                    );
                  }
                }

                if ((state.productList?.isEmpty ?? true) &&
                    state.frombottomnav) {
                  return SliverToBoxAdapter(child: Text('No products'));
                }

                if ((state.searchList?.isEmpty ?? true) &&
                    (state.frombottomnav == false)) {
                  if (state.isError) {
                    log('screen search list empty', name: 'from search screen');
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.sizeOf(context).height * .12,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Oops!!..no result for your search",
                              style: TextStyle(
                                  fontSize: 23, color: Colors.black38),
                            ),
                            Image.asset('assets/user/notFound.png',
                                height: MediaQuery.sizeOf(context).height * .3,
                                width: MediaQuery.sizeOf(context).width * .85),
                          ],
                        ),
                      ),
                    );
                  }
                }

                if ((state.productList?.isNotEmpty ?? false) &&
                    state.frombottomnav) {

                      List<ProductRegModel> productList = state.productList!
    .where((e) => e.products.isAvailable == true)
    .toList();

            
                      // (state.productList a      List<ProductRegModel> productList =state.productList.map((e) => e.products.isAvailable==true,).toList();s List<ProductRegModel>)
                      //     .map((item) => item.products)
                      //     .toList();

              //  state.productList.
              //         .where((product) => product.isAvailable == true)
              //         .toList();

                  return ProductGrid(
                    productdetail:productList,
                    bySearch: !state.frombottomnav,
                  );
                }

                if ((state.searchList?.isNotEmpty ?? false) &&
                    (state.frombottomnav == false)) {
                  log('ddddddd');
                  List<ProductRegModel>? searchList = state.searchList;
                  return ProductGrid(
                    productdetail: searchList,
                    bySearch: !state.frombottomnav,
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
          onChanged: (value) {
            context
                .read<ProductBloc>()
                .add(Productsearch(productName: searchController.text.trim()));
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
