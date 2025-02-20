import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';
import 'package:grocery_app/presentation/screens/user/cart/cart.dart';
import 'package:grocery_app/presentation/screens/user/category/category.dart';
import 'package:grocery_app/presentation/screens/user/homeScreen/homescreen.dart';
import 'package:grocery_app/presentation/screens/user/profile/user_profile.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  // int  = 0;
  ValueNotifier<int> _currentindex=ValueNotifier(0);
  final List<Widget> _screens = [
    HomeScreen(),
    ProductCategory(),
    Cart(),
    UserProfile()
  ];
  final List<IconData> _icon = [
    Icons.home,
    Icons.category,
    Icons.shopping_cart,
    Icons.person
  ];

@override
  void initState() {
       context.read<CategoryBloc>().add(CategoryGet());
    context.read<UserDashboardBloc>().add(UserDasboardGet());
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return ValueListenableBuilder(valueListenable: _currentindex,
    builder: (context, value, child) => 
       Scaffold(
        body: _screens[_currentindex.value],
        bottomNavigationBar: Stack(clipBehavior: Clip.none, children: [
          ClipPath(
            clipper: CustomClipperss(),
            child: Container
            (
          width: double.infinity,
             
              height: 75,
              child: Card(clipBehavior: Clip.hardEdge,
                child: BottomNavigationBar(iconSize: 26,
                   selectedIconTheme: IconThemeData(color: Colors.white),
                selectedFontSize:12 ,
                // unselectedFontSize: ,
                unselectedIconTheme: IconThemeData(color: Colors.white),
                selectedLabelStyle: TextStyle(color: Colors.black),
                    // selectedItemColor: Colors.black54,
                    onTap: (value) =>_currentindex.value=value,
                    currentIndex: _currentindex.value,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor:
                    // const Color.fromARGB(255, 255, 244, 212),
                     Colors.amberAccent.shade200,
                    items: [
                      BottomNavigationBarItem(
                          label: 'Home',
                          icon: Icon(
                            Icons.home,
                          )),
                      BottomNavigationBarItem(
                          label: 'Category',
                          icon: Icon(
                            Icons.category,
                          )),
                      BottomNavigationBarItem(
                          label: 'Cart',
                          icon: Icon(
                            Icons.shopping_cart,
                          )),
                      BottomNavigationBarItem(
                          label: 'Person',
                          icon: Icon(
                            Icons.person,
                          )),
                    ]),
              ),
            ),
          ),
          Positioned(
              left: MediaQuery.sizeOf(context).width*.429,
              bottom:MediaQuery.sizeOf(context).width*.14 ,
              child: FloatingActionButton(
                  backgroundColor: Colors.amber.shade400,
                  foregroundColor: Colors.white,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Icon(_icon[_currentindex.value]))),
        ]),
      ),
    );
  }
}

class CustomClipperss extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 244, 0);

    path.quadraticBezierTo(size.width / 1.9, size.height - 12,
        2 * size.width / 3.2, size.height - 100);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
// class CustomClipperss extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double radius = 35.0; // Adjust this for more or less rounding

//     Path path = Path();
    
//     // Start from the bottom-left corner with rounded edge
//     path.moveTo(0, radius);
//     path.quadraticBezierTo(0, 0, radius, 0); 

//     // Top left to center curve
//     path.lineTo(size.width - 244, 0);

//     // Custom center curve (unchanged from your design)
//     path.quadraticBezierTo(
//         size.width / 1.9, size.height - 12, 
//         2 * size.width / 3.2, size.height - 100);

//     // Top right corner with rounded edge
//     path.lineTo(size.width - radius, 0);
//     path.quadraticBezierTo(size.width, 0, size.width, radius);

//     // Move down to the bottom right
//     path.lineTo(size.width, size.height - radius);
//     path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

//     // Move left to the bottom left
//     path.lineTo(radius, size.height);
//     path.quadraticBezierTo(0, size.height, 0, size.height - radius);

//     path.close(); // Close the path

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true; // Redraw when necessary
//   }
// }


