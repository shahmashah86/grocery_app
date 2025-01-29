import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: _currentindex,
    builder: (context, value, child) => 
       Scaffold(
        body: _screens[_currentindex.value],
        bottomNavigationBar: Stack(clipBehavior: Clip.none, children: [
          ClipPath(
            clipper: CustomClipperss(),
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              height: 65,
              child: BottomNavigationBar(
                  selectedItemColor: Colors.black54,
                  onTap: (value) =>_currentindex.value=value,
                  currentIndex: _currentindex.value,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.amber.shade100,
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
          Positioned(
              left: MediaQuery.sizeOf(context).width*.429,
              bottom:MediaQuery.sizeOf(context).width*.13 ,
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
