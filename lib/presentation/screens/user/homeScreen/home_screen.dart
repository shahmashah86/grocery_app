import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/category/model/category_model.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';
import 'package:grocery_app/presentation/screens/user/product_description/product_description.dart';
import 'package:grocery_app/presentation/screens/user/search/product_search_screen.dart';
import 'package:grocery_app/presentation/screens/user/search/searchscreen.dart';
import 'package:grocery_app/presentation/screens/user/widgets/category_content.dart';
import 'package:grocery_app/presentation/screens/user/widgets/clipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  final Shader _linearGradient = const LinearGradient(
  //   colors: [ Colors.deepPurple,Colors.yellow,],
  //   begin: Alignment.centerLeft,
  //   end: Alignment.bottomRight,
  // ).createShader(const Rect.fromLTWH(0.0, 50.0, 320.0, 80.0));

  late final TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    log('hh');

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // });
//  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int?> indexOfSelcted = ValueNotifier(null);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "FRESH",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            Text(
              "MART",
              style:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(child: CircularProgressIndicator()),
                ));
              }
              if (state is CategoryLoaded) {
                List<CategoryModel>? categories = state.categoryList;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 2),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.067,
                        child: SearchBar(
                          controller: searchController,
                          leading: Icon(Icons.search),
                          elevation: WidgetStatePropertyAll(0),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.amber.shade200),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          hintText: 'search',
                          onSubmitted: (value) {
                            
                              
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductSearchScreen(
                                fromBottomNav: false,
                                searchValue: value,
                              );
                            }));
                            searchController.clear();
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 9),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ),
                    // scrolling categories
                    ValueListenableBuilder(
                      valueListenable: indexOfSelcted,
                      builder: (context, value, child) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(spacing: 5, children: [
                            SizedBox(
                              width: 4,
                            ),
                            ...List.generate(categories!.length, (index) {
                              return ChoiceChip(
                                showCheckmark: false,
                                side: BorderSide(
                                    color: Colors.amberAccent, width: 2),
                                color: WidgetStatePropertyAll(
                                    Colors.amber.shade50),
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 4),
                                  child: Row(
                                    spacing: 6,
                                    children: [
                                      Text(categories[index].name.toString()),
                                      Image.asset(
                                        'assets/user/tag1.png',
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .02,
                                      )
                                    ],
                                  ),
                                ),
                                selected: indexOfSelcted.value == index,
                                selectedColor: Colors.amber.shade300,
                                onSelected: (selected) {
                                  indexOfSelcted.value =
                                      selected ? index : null;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    final categoryId = categories[index].id;
                                    context
                                        .read<CategoryBloc>()
                                        .add(CategorylistbyId(id: categoryId));
                                    context
                                        .read<CartBloc>()
                                        .add(CartitemsGet());
                                    return CategoryContent(
                                        categoryName: categories[index].name);
                                  }));
                                  indexOfSelcted.value = null;
                                },
                              );
                            })
                          ])),
                    ),
                  ],
                );
              }

              if (state is CategoryError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(state.msg),
                  ),
                );
              } else {
                return Center(child: Text("Please wait or try again"));
              }
            },
          ),
          BlocBuilder<UserDashboardBloc, UserDashboardState>(
            builder: (context, state) {
              if (state is UserDashboardLoading) {
                return CircleAvatar(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              //dasbord api result ui
              if (state is UserDashboardsuccess) {
                return Column(
                  children: [
                    //banner

                    Card(
                      child: ClipPath(
                        clipper: CustomClippers(),
                        child: CarouselSlider.builder(
                          itemCount: state.dashboardData?.banners.length ?? 0,
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(
                              width: double.infinity,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SpinKitPulse(
                                    color: Colors.white,
                                  ),
                                  imageUrl: state.dashboardData?.banners[index]
                                          .banner ??
                                      '',
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 400),
                              height: MediaQuery.sizeOf(context).height * 0.28,
                              autoPlay: true,
                              viewportFraction: 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Row(
                        spacing: 3,
                        children: [
                          Text(
                            "Trending now",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.black54,
                          )
                        ],
                      ),
                    ),
                    //trending products
                    CarouselSlider.builder(
                      itemCount:
                          state.dashboardData?.trendingProducts.length ?? 0,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductDescription();
                            }));
                            context.read<ProductBloc>().add(Productget(
                                productId: state.dashboardData!
                                    .trendingProducts[index].id!));
                          },
                          child: Card(
                            color: Colors.lime.shade300,
                            elevation: 3,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8, right: 8),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              .19,
                                      child: CachedNetworkImage(
                                        imageUrl: state
                                                .dashboardData
                                                ?.trendingProducts[index]
                                                .image ??
                                            "",
                                        placeholder: (context, url) =>
                                            SpinKitPulse(
                                          color: Colors.white,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            state
                                                    .dashboardData!
                                                    .trendingProducts[index]
                                                    .productName ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.indigo,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "₹${state.dashboardData?.trendingProducts[index].price.toString()}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 100),
                          height: MediaQuery.sizeOf(context).height * 0.26,
                          autoPlay: true,
                          viewportFraction: .47),
                    ),
                  ],
                );
              }
              if (state is UserDashboardError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(state.message ?? ''),
                  ),
                );
              }
              return Text("loading");
            },
          ),
        ],
      ),
    );
  }
}
