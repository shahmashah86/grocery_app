import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/user/widgets/clipper.dart';



class ProductCategory extends StatelessWidget {
  final Icon? icons;
  const ProductCategory({super.key, this.icons});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> category = [
      {'category': 'Fruits & Vegetables', 'path': "assets/images/vegies.jpeg"},
      {'category': 'Meat & Eggs', 'path': "assets/images/meat1.jpeg"},
      {'category': 'Snacks & Foods', 'path': "assets/images/snacks.jpeg"},
      {'category': 'Bakery Diary', 'path': "assets/images/grains.jpeg"},
      {'category': 'Oil,Spices,Pickles', 'path': "assets/images/oils.jpeg"},
      {'category': 'Beverages & Drinks', 'path': "assets/images/juice.jpeg"},
      {'category': 'Sugar,Salt & Grain"', 'path': "assets/images/grains.jpeg"},
      {'category': 'PersonalCare', 'path': "assets/images/personal_care.jpeg"},
      {'category': 'Baby & kids', 'path': "assets/images/baby.jpeg"},
      {'category': 'Household', 'path': "assets/images/household.jpeg"},
      {'category': 'stationary', 'path': "assets/images/stationaties.jpeg"}
    ];
    List<String> banner=["assets/banner/UPTO 50%.jpg","assets/banner/Offer.jpg"];
    return Scaffold(
      body: Column(children: [
        ClipPath(
        clipper: CustomClippers(),
        child:
        CarouselSlider.builder(
          itemCount: banner.length,
          itemBuilder: (context, index, realIndex) {
            return Container(padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(banner[index]),fit: BoxFit.cover)),
            );
          },
          //  items: [Container(
          //   color: Colors.amber,
          //   // height: MediaQuery.sizeOf(context).height * 0.3,
          //   // width: double.infinity,
          //            ),
          //            Container(
          //   color: const Color.fromARGB(255, 84, 71, 34),
          //   // height: MediaQuery.sizeOf(context).height * 0.3,
          //   // width: double.infinity,
          //            ),],
          options: CarouselOptions(autoPlayAnimationDuration: Duration(milliseconds: 400),
              height:   MediaQuery.sizeOf(context).height * 0.34, autoPlay: true,viewportFraction: 1),
        ),
        ),
        Container(
            padding: EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shop by category",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color:Colors.indigo),
                    //  const Color.fromARGB(255, 147, 144, 144)),
              ),
            )),
        Expanded(
          child: GridView.builder(
              padding: EdgeInsets.only(left: 8, right: 8),
              itemCount: category.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  // color: 
                  // Colors.yellow.shade100,
                  // Colors.amber.shade50,
                  child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Center(
                            child: Text(
                          category[index]['category']!,
                          style: TextStyle(fontSize: 17),
                        )),
                      ),
                      header: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: ClipPath(
                          clipper: CustomClippers_card(),
                          child: Image.asset(
                            category[index]['path']!,
                            fit: BoxFit.cover,
                            height: MediaQuery.sizeOf(context).height * 0.18,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      child: Container()),
                );
              }),
        )
      ]),
    );
  }
}

class CustomClippers_card extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 16);
    //  path.cubicTo(size.width/2, size.height-20, 2*size.width/2, size.height, size.width,size.height);
    path.cubicTo(size.width / 4, size.height + 35, size.width / 2 - 50,
        size.height - 50, size.width / 2 - 10, size.height - 30);
    path.cubicTo(size.width / 2 + 45, size.height + 20, 3 * size.width / 4.5,
        size.height - 80, size.width, size.height - 34);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
