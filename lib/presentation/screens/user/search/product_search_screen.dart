import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:grocery_app/presentation/screens/user/cart/cart.dart';
import 'package:grocery_app/presentation/screens/user/widgets/product_grid.dart';

class ProductSearchScreen extends StatefulWidget {
  final bool fromBottomNav;
  final String? searchValue;
  const ProductSearchScreen(
      {super.key, required this.fromBottomNav, this.searchValue});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    //cart items getting initailly for finding the count of cart items
    context.read<CartBloc>().add(CartitemsGet());
    searchController = TextEditingController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!widget.fromBottomNav) {
        log(widget.searchValue!, name: "search Data");
       
      }
      context.read<ProductSearchBloc>().add(ProductList(
          productName: widget.searchValue ?? "",
          frombottomnav: widget.fromBottomNav));
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height * .16,
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
          if (widget.fromBottomNav)
            SliverPersistentHeader(
              pinned: true,
              delegate:
                  SearchBarDelegate(searchController, widget.fromBottomNav),
            ),

          BlocBuilder<ProductSearchBloc, ProductSearchState>(
            builder: (context, state) {
              if (state is ProductSearchLoading) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * .5,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              if (state is ProductSearchLoaded) {
                if (state.isLoading) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * .5,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
                

                return ProductGrid(
                  productdetail:
                      (widget.fromBottomNav && searchController.text.isEmpty)
                          ? state.productList.where((test)=>test.products.isAvailable==true).toList()
                          : (!widget.fromBottomNav && widget.searchValue=="")
                              ? state.productList.where((test)=>test.products.isAvailable==true).toList()
                              : state.searchList,
                  // bySearch:
                  //     (widget.fromBottomNav && searchController.text.isEmpty)
                  //         ? false
                  //         :(!widget.fromBottomNav && widget.searchValue=="")
                  //             ? false
                  //             : true,
                );
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
  final bool fromBottomNav;
  SearchBarDelegate(this.searchController, this.fromBottomNav);

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
            log(value, name: "Search Value");
            context.read<ProductSearchBloc>().add(ProductSearch(
                productName: value, frombottomnav: fromBottomNav));
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
