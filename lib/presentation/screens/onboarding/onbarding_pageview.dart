import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/presentation/screens/onboarding/onboarding1.dart';
import 'package:grocery_app/presentation/screens/onboarding/onboarding2.dart';
import 'package:grocery_app/presentation/screens/onboarding/onboarding3.dart';

class OnbardingPageview extends StatefulWidget {
  const OnbardingPageview({super.key});

  @override
  State<OnbardingPageview> createState() => _OnbardingContentState();
}

class _OnbardingContentState extends State<OnbardingPageview> {
 late final PageController  _pageController;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
_pageController=PageController();
     

    super.initState();
  }
  @override
  void dispose() {
    // Future.delayed(Duration(milliseconds: 100));
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

        
      
     _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller:_pageController ,children: [Onboarding1(),Onboarding2(),Onboarding3()],),
    );
  }
}

