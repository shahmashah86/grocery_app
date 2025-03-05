




import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/onboarding/onboarding2.dart';


class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
     
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromARGB(255, 254, 227, 186),
        ),
        ClipPath(
          clipper: CustomClipperClass(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: double.infinity,
            color: Colors.orange,
            child: Image.asset(
              'assets/images/bagcolored.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.22,
            left: 10,
            child: Text(
              "Your daily essentials,\n just a tap away",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 82, 81, 81)),
            )),
        Positioned(
            bottom: 30,
            right: MediaQuery.of(context).size.width * 0.1,
            child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
              return Onboarding2();
            })),
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.amber,),
              
              height: 50,
              width: 100,
              child: Center(child: Text("Skip Now",style: TextStyle(fontWeight: FontWeight.w500),)),
            )))
      ]),
    );
  }
}

class CustomClipperClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.moveTo(0, 0);
    path.lineTo(0, size.height - 80);
    path.lineTo(size.width, size.height);
    // path.arcToPoint(Offset.fromDirection(size.height*0.9,),radius:Radius.circular(3),rotation: 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    // throw UnimplementedError();
    return true;
  }
}
