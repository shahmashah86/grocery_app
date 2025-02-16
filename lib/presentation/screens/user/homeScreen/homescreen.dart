import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/common/category/model/category_model.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';
import 'package:grocery_app/presentation/screens/user/search/searchscreen.dart';
import 'package:grocery_app/presentation/screens/user/widgets/bottom_navigation.dart';
import 'package:grocery_app/presentation/screens/user/widgets/category_content.dart';

import 'package:grocery_app/presentation/screens/user/widgets/clipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
     context.read<CategoryBloc>().add(CategoryGet());
    context.read<UserDashboardBloc>().add(UserDasboardGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> images = [
      {
        "path": 'assets/images/bananas.jpg',
        "description": "OFFER 20% ENDS SOON ⏰"
      },
      {"path": 'assets/images/meat1.jpeg', "description": "Up To 10% Off"}
    ];
    List<String> banner = [
      "assets/banner/UPTO 50%.jpg",
      "assets/banner/Offer.jpg"
    ];
    ValueNotifier<int> indexOfSelcted = ValueNotifier(-1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
        toolbarHeight: 20,
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if(state is CategoryLoaded){
                List<CategoryModel>? categories=state.categoryList;
                   return Column(
                children: [
                  SizedBox(
                    height: 56,
                    child: SearchBar(
                      leading: Icon(Icons.search),
                      elevation: WidgetStatePropertyAll(0),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.amber.shade200),
                      shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                      hintText: 'search',
                      onSubmitted: (value) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Searchscreen();
                      })),
                    ),
                  ),
             
          SizedBox(
            height: 1,
          ),
          Container(
            color: Colors.amber.shade50,
            child: ValueListenableBuilder(
              valueListenable: indexOfSelcted,
              builder: (context, value, child) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 10, top: 3, bottom: 3),
                    child: Wrap(spacing: 3, children: [
                      ...List.generate(categories!.length, (index) {
                        return ChoiceChip(
                          color: WidgetStatePropertyAll(Colors.amber.shade100),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 20),
                            child: Text(categories[index].name.toString()),
                          ),
                          selected: indexOfSelcted.value == index,
                          selectedColor:
                              const Color.fromARGB(179, 241, 234, 234),
                          onSelected: (selected) {
                            
                            indexOfSelcted.value = selected ? index : index;
                            // Navigator.push(context, MaterialPageRoute(builder: (context){
                            //   return CategoryContent();
                            // }));
                            
                          },
                        );
                      })
                    ]),
                  )),
            ),
          ),
             ],
              );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 56,
                    child: SearchBar(
                      leading: Icon(Icons.search),
                      elevation: WidgetStatePropertyAll(0),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.amber.shade200),
                      shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                      hintText: 'search',
                      onSubmitted: (value) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Searchscreen();
                      })),
                    ),
                  ),
             
          SizedBox(
            height: 1,
          ),
          Container(
            color: Colors.amber.shade50,
            child: ValueListenableBuilder(
              valueListenable: indexOfSelcted,
              builder: (context, value, child) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 10, top: 3, bottom: 3),
                    child: Wrap(spacing: 3, children: [
                      ...List.generate(10, (index) {
                        return ChoiceChip(
                          color: WidgetStatePropertyAll(Colors.amber.shade100),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 39),
                            child: Text("veg"),
                          ),
                          selected: indexOfSelcted.value == index,
                          selectedColor:
                              const Color.fromARGB(179, 241, 234, 234),
                          onSelected: (selected) {
                            indexOfSelcted.value = selected ? index : index;
                          },
                        );
                      })
                    ]),
                  )),
            ),
          ),
             ],
              );
            },
          ),
          BlocBuilder<UserDashboardBloc, UserDashboardState>(
            builder: (context, state) {
              if (state is UserDashboardsuccess) {
                return Column(
                  children: [
                    ClipPath(
                      clipper: CustomClippers(),
                      child: CarouselSlider.builder(
                        itemCount: state.dashboardData?.banners.length ?? 0,
                        itemBuilder: (context, index, realIndex) {
                          return CachedNetworkImage(
                            imageUrl:
                                state.dashboardData?.banners[index].banner ??
                                    '',
                            errorWidget: (context, url, error) => Container(
                              color: Colors.amber,
                            ),
                          );
                        },
                        options: CarouselOptions(
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 400),
                            height: MediaQuery.sizeOf(context).height * 0.34,
                            autoPlay: true,
                            viewportFraction: 1),
                      ),
                    ),
                    CarouselSlider.builder(
                      itemCount:
                          state.dashboardData?.trendingProducts.length ?? 0,
                      itemBuilder: (context, index, realIndex) {
                        return Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.yellow.shade50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 10, left: 8, right: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: state
                                                .dashboardData
                                                ?.trendingProducts[index]
                                                .image ??
                                            "",
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 12, left: 12, right: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        state
                                                .dashboardData!
                                                .trendingProducts[index]
                                                .productName ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.indigo),
                                      ),
                                      Spacer(),
                                      Text(
                                        "₹${state.dashboardData?.trendingProducts[index].price.toString()}",
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.indigo),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 100),
                          height: MediaQuery.sizeOf(context).height * 0.31,
                          autoPlay: true,
                          viewportFraction: .6),
                    ),
                  ],
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
