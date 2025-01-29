import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/user/profile/edit_profile/edit_profile.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    void _onTapped() {
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  const EditProfile()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: Column(
        spacing: 10,
        children: [
          SizedBox(height: 6),
          Row(
            spacing: 17,
            children: [SizedBox(width: 4),
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 55,
                child: Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.black54,
                ),
              ),
              Text(
                "Hey! User123",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: MediaQuery.sizeOf(context).width * 0.02,
              children: [
                Container(
                  height: 70,
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Icon(Icons.shopping_cart),
                      Text(
                        "My Orders",
                      )
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber.shade100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Icon(Icons.help_outline_outlined),
                      Text(
                        "Help Center",
                      )
                    ],
                  ),
                ),
              ]),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.035,
          ),
          // Container(child: Text("phone No:"),decoration: BoxDecoration(border: Border.all(color:Colors.amber.shade200,width: 1 )),
          // height: 50,width: MediaQuery.sizeOf(context).width * 0.94,),
          // SizedBox(height: 10,),
          Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  spacing: 15,
                  children: [
                    Icon(Icons.edit_outlined),
                    Text("Edit Profile"),
                    Spacer(),
                    InkWell(
                      onTap:
                        _onTapped,
                    
                      child: CircleAvatar(
                        foregroundColor: Colors.black54,
                        backgroundColor: Colors.amber.shade300,
                        child: Icon(
                          Icons.chevron_right,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomPaint(
                painter: DashedLinePainter(),
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  spacing: 15,
                  children: [
                    Icon(Icons.favorite_outline),
                    Text("Wishlist"),
                    Spacer(),
                    InkWell(
                      // onTap: 
                      child: CircleAvatar(
                        foregroundColor: Colors.black54,
                        backgroundColor: Colors.amber.shade300,
                        child: Icon(Icons.chevron_right),
                      ),
                    )
                  ],
                ),
              ),
              CustomPaint(
                painter: DashedLinePainter(),
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  spacing: 15,
                  children: [
                    Icon(Icons.location_history_outlined),
                    Text("My Addres"),
                    Spacer(),
                    InkWell(
                      onTap:  (){},
                      child: CircleAvatar(
                        backgroundColor: Colors.amber.shade300,
                        foregroundColor: Colors.black54,
                        child: Icon(Icons.chevron_right),
                      ),
                    )
                  ],
                ),
              ),
              CustomPaint(
                painter: DashedLinePainter(),
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  spacing: 15,
                  children: [
                    Icon(Icons.logout),
                    Text("Sign Out"),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.amber.shade300,
                      foregroundColor: Colors.black54,
                      child: Icon(Icons.chevron_right),
                    )
                  ],
                ),
              ),
              CustomPaint(
                painter: DashedLinePainter(),
                child: Container(),
              ),
            ],
          )
          // Container(decoration: BoxDecoration(border: Border.all(color:Colors.amber.shade200,width: 2 )),
          // height: 50,width: MediaQuery.sizeOf(context).width * 0.94),
          // Container(decoration: BoxDecoration(border: Border.all(color:Colors.amber.shade200,width: 2 )),
          // height: 50,width: MediaQuery.sizeOf(context).width * 0.94)
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 19, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.amber.shade200
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
