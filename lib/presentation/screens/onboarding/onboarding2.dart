import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/onboarding/onboarding3.dart';




class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 232, 184, 112),
          child: Column(
            children: [
              ClipPath(
                clipper: CustomClipperClass2(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.73,
                  width: double.infinity,
                  color: Colors.orange,
                  child: Image.asset(
                    'assets/images/apricot.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            ],
          ),
        ),
        Positioned(
            bottom: 30,
            right: MediaQuery.of(context).size.width * 0.1,
            child: InkWell(
                onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return
                       Onboarding3();
                    })),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 50,
                  width: 100,
                  child: Center(
                      child: Text(
                    "Skip Now",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                )))
      ]),
    );
  }
}

class CustomClipperClass2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.moveTo(0, size.height);
    path.lineTo(0, size.height);
    // path.lineTo(200, size.height);
    path.cubicTo(220, 2 * size.height / 2, 120, 220, size.width, size.height);
    // path.cubicTo(size.width/2, size.height-120, 2.5*size.width/4, size.height+60, size.width, size.height-75);
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
