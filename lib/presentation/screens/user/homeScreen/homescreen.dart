import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/user/search/searchscreen.dart';
import 'package:grocery_app/presentation/screens/user/widgets/bottom_navigation.dart';

import 'package:grocery_app/presentation/screens/user/widgets/clipper.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
    
      appBar: AppBar(backgroundColor: Colors.amber.shade200,toolbarHeight: 20,),

      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: SearchBar(
              leading: Icon(Icons.search),
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.amber.shade200),
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              hintText: 'search',
              onSubmitted: (value) =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Searchscreen();
              })),
            ),
          ),

          ClipPath(
            clipper: CustomClippers(),
            child: CarouselSlider.builder(
              itemCount: banner.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
            
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(banner[index]), fit: BoxFit.cover)),
                );
              },
          
              options: CarouselOptions(
                  autoPlayAnimationDuration: Duration(milliseconds: 400),
                  height: MediaQuery.sizeOf(context).height * 0.33,
                  autoPlay: true,
                  viewportFraction: 1),
            ),
          ),
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              return Card(
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow.shade50
                      ),
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
                                image: DecorationImage(
                                    image: AssetImage(images[index]["path"]!),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 12),
                        child: Text(
                          images[index]["description"]!,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
                autoPlayAnimationDuration: Duration(milliseconds: 100),
                height: MediaQuery.sizeOf(context).height * 0.33,
                autoPlay: true,
                viewportFraction: 1),
          ),
        
        ],

      ),
    );
  }
}
