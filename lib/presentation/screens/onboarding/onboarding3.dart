import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/authentication/login.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromARGB(255, 244, 227, 201),
        ),
        ClipPath(
          clipper: CustomClipperClass3(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.52,
            width: double.infinity,
            color: Colors.orange,
            child: Image.asset(
              'assets/images/face.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.36,
            left: 10,
            child: Text(
              textAlign: TextAlign.left,
              "Expolre Healthy Options",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 60, 60, 60)),
            )),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.28,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Healthy living starts here.Simplify your\ngrocery shopping here!!",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 94, 93, 93)),
              ),
            )),
        Positioned(
            bottom: 50,
            right: MediaQuery.of(context).size.width * 0.1,
            child: InkWell(
                onTap: () => Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context)=>Login()),(route)=>false
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
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

class CustomClipperClass3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.moveTo(0, 0);
    path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height*0.95);

    path.cubicTo(size.width / 2, size.height - 120, 2.5 * size.width / 4,
        size.height + 60, size.width, size.height - 75);

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
