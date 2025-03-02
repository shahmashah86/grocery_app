import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/category/model/category_model.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';
import 'package:grocery_app/presentation/screens/user/search/searchscreen.dart';
import 'package:grocery_app/presentation/screens/user/widgets/category_content.dart';
import 'package:grocery_app/presentation/screens/user/widgets/clipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
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
        // backgroundColor: Colors.amber.shade200,
        // toolbarHeight: 20,
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return Center(
                    child: CircleAvatar(child: CircularProgressIndicator()));
              }
              if (state is CategoryLoaded) {
                List<CategoryModel>? categories = state.categoryList;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // spacing: 2,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 6),
                      child: SizedBox(
                        height: 56,
                        child: SearchBar(
                          controller: searchController,
                          leading: Icon(Icons.search),
                          elevation: WidgetStatePropertyAll(0),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.amber.shade200),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          hintText: 'search',
                          onSubmitted: (value)
                           {
                            // if(searchController.text.trim().isNotEmpty){
                            context.read<ProductBloc>().add(Productsearch(
                                productName: searchController.text.trim()));
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Searchscreen(searchfromDashboard: true,);
                            }));
                            searchController.clear();
                            // }
                            // else{
                            //      ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            //         content: Text(
                            //           "nothing to search",
                            //           style: TextStyle(color: Colors.white),
                            //         ),
                            //         duration: Duration(seconds: 1),
                            //         behavior: SnackBarBehavior.floating,
                            //       ),
                            //     );
                              
                            // }
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "categories",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    // scrolling categories
                    ValueListenableBuilder(
                      valueListenable: indexOfSelcted,
                      builder: (context, value, child) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(spacing: 5, children: [
                            ...List.generate(categories!.length, (index) {
                              return ChoiceChip(
                                showCheckmark: false,
                                side: BorderSide(
                                    color: Colors.amberAccent, width: 2),
                                color: WidgetStatePropertyAll(
                                    Colors.amber.shade50),
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child:
                                      Row(spacing: 6,
                                        children: [
                                          Text(categories[index].name.toString()),  Image.asset('assets/user/tag1.png',height: 20,)
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
                  child: Text(state.msg),
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
                  child: CircularProgressIndicator(),
                );
              }
              //dasbord api result ui
              if (state is UserDashboardsuccess) {
                return Column(
                  children: [
                    SizedBox(
                      height: 2,
                    ),

                    //banner

                    Card(
                      child: ClipPath(
                        clipper: CustomClippers(),
                        child: CarouselSlider.builder(
                          itemCount: state.dashboardData?.banners.length ?? 0,
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(width: double.infinity,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SpinKitPulse(
                                    color: Colors.white,
                                  ),
                                  imageUrl: state
                                          .dashboardData?.banners[index].banner ??
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
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              // autoPlay: false,
                              viewportFraction: 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        spacing: 3,
                        children: [
                          Text(
                            "trending now",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    //trending products
                    CarouselSlider.builder(
                      itemCount:
                          state.dashboardData?.trendingProducts.length ?? 0,
                      itemBuilder: (context, index, realIndex) {
                        return Card(
  color: Colors.lime.shade400,
  elevation: 3,
  clipBehavior: Clip.hardEdge,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),  // Round only top-left corner
      topRight: Radius.circular(10), // Round only top-right corner
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0,top: 8,right:8 ),
        child: SizedBox(width: double.infinity,height:  180,
          child: CachedNetworkImage(
            imageUrl: state.dashboardData?.trendingProducts[index].image ?? "",
            placeholder: (context, url) => SpinKitPulse(
              color: Colors.white,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 4,top: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
          children: [
            Expanded(
              child: Text(maxLines: 1,overflow: TextOverflow.ellipsis,
                state.dashboardData!.trendingProducts[index].productName ?? "",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo,
                ),
              ),
            ),
            // SizedBox(height: 2), // Add spacing
            Text(
              "₹${state.dashboardData?.trendingProducts[index].price.toString()}",
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w500,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

                        // return Card(color: Colors.lime.shade400,
                        //   elevation: 3,clipBehavior: Clip.hardEdge,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Expanded(
                        //         child: CachedNetworkImage(
                        //           imageUrl: state
                        //                   .dashboardData
                        //                   ?.trendingProducts[index]
                        //                   .image ??
                        //               "",
                        //           placeholder: (context, url) =>
                        //               SpinKitPulse(
                        //             color: Colors.white,
                        //           ),
                        //           errorWidget: (context, url, error) =>
                        //               Icon(Icons.error),
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //   Text(
                        //     state.dashboardData!
                        //                     .trendingProducts[index]
                        //                     .productName ??
                        //                 "",
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.indigo
                                                    
                        //             )
                        //   ),
                        //       Text(
                        //             "₹${state.dashboardData?.trendingProducts[index].price.toString()}",
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.indigo),
                        //           )
                             
                        //     ],
                        //   ),
                        // );
                      },
                      options: CarouselOptions(
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 100),
                          height: MediaQuery.sizeOf(context).height * 0.27,
                          // autoPlay: true,
                          viewportFraction: .47),
                    ),
                  ],
                );
              }
              if(state is UserDashboardError){
                return Center(child: Text(state.message??''),);
              }
              return Text("loading");
            },
          ),
        ],
      ),
    );
  }
}
