import 'package:flutter/material.dart';

import 'package:grocery_app/presentation/screens/user/pdoduct_description/product_description.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> searchList = [
      {
        'image': "assets/images/strawberry.jpeg",
        'Text': 'Strawberry',
        "Price": '25/kg',
        'description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals.\n Packed with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness.Order now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/bananas.jpg",
        'Text': 'Robust\nbanana',
        "Price": '45/kg',
        'description':
            "Fresh and juicy strawberries, bursting with natural sweetness!/nPerfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals. \nPacked with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness\n\n Order now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/blueberries.jpg",
        'Text': 'blueberry',
        "Price": '25/kg',
        'description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals.\n Packed with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness.\n Order now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/pexels-arina-krasnikova.jpg",
        'Text': 'krasnikiva\nraw',
        "Price": '25/kg','description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals.\n Packed with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness.\n Order now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/strawberry.jpeg",
        'Text': 'Strawaberry',
        "Price": '25/kg','description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals. Packed with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness.\n Order now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/blueberries.jpg",
        'Text': 'blueberry',
        "Price": '25/kg','description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals.\n Packed with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness. \nOrder now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/bananas.jpg",
        'Text': 'banana',
        "Price": '35/kg',
        'description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals. \nPacked with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness.\n Order now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/strawberry.jpeg",
        'Text': 'Strawaberry\n Farm',
        "Price": '25/kg','description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals.\n Packed with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness. \nOrder now and enjoy the taste of nature’s sweetness!"
      
      },
      {
        'image': "assets/images/strawberry.jpeg",
        'Text': 'Strwaberry',
        "Price": '25/kg','description':
            "Fresh and juicy strawberries, bursting with natural sweetness! Perfect for snacking, smoothies, desserts, or adding a pop of flavor to your meals.\n Packed with vitamins and antioxidants, our strawberries are hand-picked for quality and freshness.\n Order now and enjoy the taste of nature’s sweetness!"
      
      }
    ];

    return Scaffold(
      appBar: AppBar(toolbarHeight: 30,backgroundColor: Colors.amber.shade200,),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: SearchBar(
                leading: Row(
                  children: [IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_left)),
                    Icon(Icons.search),
                  ],
                ),
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Colors.amber.shade200),
                shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                hintText: 'search'),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            // child: StaggeredGridView.countBuilder(padding: EdgeInsets.only(left: 8,right: 8),
            //   crossAxisSpacing: 10,mainAxisSpacing: 10,
            //   crossAxisCount: 2, itemBuilder: (context,index){return

            //       Container(color:Colors.amber.shade100,
            //         child: Column(
            //           children:[ Container(width:MediaQuery.of(context).size.width*0.55 ,
            //            height:MediaQuery.of(context).size.height*0.25 ,
            //            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/strawberry.jpeg",),fit: BoxFit.cover),
            //            borderRadius: BorderRadius.circular(10)),),
            //               Text("Image")]),
            //       );
            //  },
            //  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            //  itemCount: 15,),

            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.only(left: 8, right: 8),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return ProductDescription(
                      description:searchList[index]['description'],
                      imgpath: searchList[index]['image'],
                      producName: searchList[index]['Text'],
                      price: searchList[index]['Price'],
                      
                    );
                  })),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(searchList[index]['image']),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 4, top: 4),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchList[index]['Text'],
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black),
                                      ),
                                      Text(searchList[index]['description'],overflow: TextOverflow.ellipsis),
                                      Text("Price:${searchList[index]['Price']}")
                                    ]),
                              ),
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
              itemCount: searchList.length,
            ),
          )
            ],
            
      ),
      // bottomNavigationBar: BottomNavigation(),
    );
  }
}
