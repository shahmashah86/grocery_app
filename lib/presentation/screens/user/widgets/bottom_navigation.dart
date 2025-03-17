import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/user_dashboard/user_dashboard_bloc.dart';
import 'package:grocery_app/presentation/screens/user/cart/cart.dart';
import 'package:grocery_app/presentation/screens/user/homeScreen/home_screen.dart';
import 'package:grocery_app/presentation/screens/user/profile/user_profile.dart';
import 'package:grocery_app/presentation/screens/user/search/product_search_screen.dart';
import 'package:grocery_app/presentation/screens/user/search/searchscreen.dart';
import 'package:grocery_app/presentation/screens/user/widgets/clipper.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // int  = 0;
  final ValueNotifier<int> _currentindex = ValueNotifier(0);
  DateTime? lastPressed;
  final List<Widget> _screens = [
    HomeScreen(),
    // Searchscreen(
    //   searchfromDashboard: false,
    // ),
    ProductSearchScreen(fromBottomNav: true,),
    Cart(),
    UserProfile()
  ];
  final List<IconData> _icon = [
    Icons.home,
    Icons.search,
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
    //for popping on botomnav icon press
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentindex.value != 0) {
          _currentindex.value = 0;
        } else {
          DateTime now = DateTime.now();
          if (lastPressed == null ||
              now.difference(lastPressed!) > Duration(seconds: 1)) {
            lastPressed = now;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(margin: EdgeInsets.only(bottom: 26,left: 22,right: 22),
              padding: EdgeInsets.all(10),
              

              behavior:SnackBarBehavior.floating ,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: Center(child: Text("Press again to exit"))));
          } else {

             SystemNavigator.pop(); 
          

          }
        }
      },
      //for screen change accirding to bottom nav icon press
      child: ValueListenableBuilder(
        valueListenable: _currentindex,
        builder: (context, value, child) => Scaffold(
          body: _screens[_currentindex.value],
           bottomNavigationBar:CurvedNavigationBar(animationDuration: Duration(milliseconds: 500),
            backgroundColor: Colors.white,
            buttonBackgroundColor: Colors.amber,color: Colors.amber.shade200,
            items:[ 
           CurvedNavigationBarItem(
                            label: 'Home',
                            child: Icon(
                              Icons.home_outlined,
                            )),
                    CurvedNavigationBarItem(
                            label: 'Search',
                            child:  Icon(
                              Icons.search_outlined,
                            )),
                        CurvedNavigationBarItem(
                            label: 'Cart',
                            child: Icon(
                              Icons.shopping_cart_outlined,
                            )),
                        CurvedNavigationBarItem(
                            label: 'Person',
                            child: Icon(
                              Icons.person_outline,
                            )),],
                                          onTap: (value) => _currentindex.value = value,
                      index: _currentindex.value,
                     
                    
           ) ,

          // bottomNavigationBar: Stack(clipBehavior: Clip.none, children: [
          //   ClipPath(
          //     clipper: CustomClipperssBottomNav(),
          //     child: Card(
          //       clipBehavior: Clip.hardEdge,
          //       child: SizedBox(height: MediaQuery.sizeOf(context).height*.08,
          //         child: BottomNavigationBar(
          //             iconSize: 26,
          //             selectedIconTheme:
          //                 IconThemeData(color: Colors.grey.shade700),
          //             selectedFontSize: 12,
                                
          //             unselectedIconTheme:
          //                 IconThemeData(color: Colors.grey.shade700),
          //             selectedLabelStyle: TextStyle(color: Colors.black),
                               
          //             onTap: (value) => _currentindex.value = value,
          //             currentIndex: _currentindex.value,
          //             type: BottomNavigationBarType.fixed,
          //             backgroundColor:
                               
          //                 Colors.amber.shade200,
          //             items: [
          //               BottomNavigationBarItem(
          //                   label: 'Home',
          //                   icon: Icon(
          //                     Icons.home_outlined,
          //                   )),
          //               BottomNavigationBarItem(
          //                   label: 'Search',
          //                   icon: Icon(
          //                     Icons.search_outlined,
          //                   )),
          //               BottomNavigationBarItem(
          //                   label: 'Cart',
          //                   icon: Icon(
          //                     Icons.shopping_cart_outlined,
          //                   )),
          //               BottomNavigationBarItem(
          //                   label: 'Person',
          //                   icon: Icon(
          //                     Icons.person_outline,
          //                   )),
          //             ]),
          //       ),
          //     ),
          //   ),
          //   Positioned(
          //       left: MediaQuery.sizeOf(context).width * .4,
          //       bottom: MediaQuery.sizeOf(context).height * .09,
          //       child: SizedBox(height:  MediaQuery.sizeOf(context).height * .065,
          //         child: FloatingActionButton(
          //             backgroundColor: Colors.amber.shade400,
          //             foregroundColor: Colors.grey.shade700,
          //             shape: CircleBorder(),
          //             onPressed: () {},
          //             child: Icon(_icon[_currentindex.value])),
          //       )),
          // ]),
        ),
      ),
    );
  }
}



