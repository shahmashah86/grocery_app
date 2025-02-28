import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/authentication/login.dart';
import 'package:grocery_app/presentation/screens/user/profile/user_orders/user_orders.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final ImagePicker _picker = ImagePicker();

  ValueNotifier<File?> selectedImage = ValueNotifier(null);

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    XFile? xfilePick = pickedFile;
    if (xfilePick != null) {
      selectedImage.value = File(xfilePick.path);

      log(selectedImage.value.toString(), name: 'image file');
      log(userdetails.value[4].toString());
      // ignore: use_build_context_synchronously
      context.read<AuthBloc>().add(UploadProfile(
          userid: userdetails.value[4], profileImage: selectedImage.value!));
    } else {
      return;
    }
  }

  TextEditingController phoneNumbercontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    loadUserData();

    super.initState();
  }

  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  int? id;
  ValueNotifier<List<dynamic>> userdetails =
      ValueNotifier(['', 'unknown user', '', '', '']);

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('user_email');

    name = prefs.getString('name');

    phone = prefs.getString('user_phone');
    imageUrl = prefs.getString('user_image_url') ?? imageUrl;
    id = prefs.getInt('user_id');
    userdetails.value = [
      email ?? '',
      name ?? '',
      phone ?? '',
      imageUrl ?? '',
      id
    ];
    phoneNumbercontroller.text = phone ?? '';
    emailController.text = email ?? '';
    nameController.text = name!;
  }
  // Future<String?> loadImage() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   imageUrl = prefs.getString('user_image_url') ?? "";
  //   return imageUrl;
  // }

  @override
  Widget build(BuildContext context) {
    log(name ?? '', name: 'userdetails');
    log(email ?? '');
    log(id.toString());

     Future<String?> readuserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('user_name') ?? "";

    return username;
  }

    Future<void> showdialog(bool toEdit) async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
  
              content: SizedBox(
                height: 235,
                width: 300,
                child: Column(
                  
                  spacing: 12,
                  children: [
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text('name')),
                    ),
                    TextFormField(
                      controller: phoneNumbercontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Phone no")),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text('email')),
                    )
                  ],
                ),
              ),
              actions: [
                toEdit
                    ? ElevatedButton(onPressed: () async{
                    final username=await readuserName();
                    log(username.toString());
                    log(id.toString());

                      final userdataToupdate=AuthModel(name: nameController.text.trim(),username: username,id: id,phoneNumber: phoneNumbercontroller.text.trim(),
                      email: emailController.text.trim(),);
                      log(userdataToupdate.toString(),name: 'userdatatoupdate');
                      
                     context.read<AuthBloc>().add(Updateuser(userdataToupdate, userIdforupdate: id!));
                    }, child: Text("submit"),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),)
                    : SizedBox.shrink(),
                    TextButton(onPressed: (){
                       Navigator.pop(context);
                    }, child: Text("Go back"),style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.black12)),)
              
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.amber.shade200,
      ),
      body: ValueListenableBuilder(
        valueListenable: userdetails,
        builder: (context, value, child) => Column(
          spacing: 14,
          children: [
            SizedBox(height: 6),
            Row(
              spacing: 17,
              children: [
                SizedBox(width: 4),
                ValueListenableBuilder(
                  valueListenable: selectedImage,
                  builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is Authupdated) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 55,
                            backgroundImage: state.imageUrl != ''
                                ? NetworkImage(state.imageUrl)
                                : null,
                            child: state.imageUrl.isEmpty
                                ? Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Colors.black54,
                                  )
                                : null,
                          );
                        }
                        return Stack(children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 48,
                            backgroundImage: NetworkImage(
                                userdetails.value[3] != '' ||
                                        userdetails.value[3] == null
                                    ? userdetails.value[3]
                                    : ''),
                            child: userdetails.value[3] == '' ||
                                    userdetails.value[3] == null
                                ? Icon(
                                    Icons.camera_alt,
                                    size: 45,
                                    color: Colors.black54,
                                  )
                                : null,
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.greenAccent.shade400,
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 30,
                                  ))))
                        ]);
                      },
                    ),
                  ),
                ),
                Text(
                  userdetails.value[1],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: MediaQuery.sizeOf(context).width * 0.02,
                children: [
                  InkWell(onTap: (){Navigator.push(context, (MaterialPageRoute(builder: (context){
                    return UserOrders();
                
                    
                  })));
                  context.read<OrdersBloc>().add(OrdersbyUser(userId: id!));

                  },
                    child: Container(
                      height: 70,
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amberAccent,
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
                  ),
                  Container(
                    height: 70,
                    width: MediaQuery.sizeOf(context).width * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amberAccent),
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

            Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    spacing: 15,
                    children: [
                      Icon(Icons.location_history_outlined),
                      Text("My Info"),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showdialog(false);
                          // _onTapped(false);
                        },
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
                      Icon(Icons.edit_outlined),
                      Text("Edit Profile"),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          // _onTapped(true);
                          showdialog(true);
                        },
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
                      Icon(Icons.logout),
                      Text("Sign Out"),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();

                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }), (route) => false);
                        },
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
                      Icon(Icons.delete_forever_outlined),
                      Text("Delete Account"),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                  title: Text("Are you sure?"),
                                  content: Text(
                                    textAlign: TextAlign.center,
                                    "Do you really want to delete this account? This process cannot be undone",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.black38)),
                                        child: Text("Cancel",
                                            style: TextStyle(
                                                color: Colors.white))),
                                    BlocListener<AuthBloc, AuthState>(
                                      listener: (context, state) async {
                                        if (state is Authupdated &&
                                            state.message == 'Deleted user') {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                          Navigator.pushAndRemoveUntil(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Login();
                                          }), (route) => false);
                                        }
                                      },
                                      child: TextButton(
                                          onPressed: () {
                                            log(id.toString());
                                            context
                                                .read<AuthBloc>()
                                                .add(Deleteuser(userId: id!));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.amber)),
                                          child: Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.indigo),
                                          )),
                                    ),
                                  ],
                                );
                              });
                        },
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
              ],
            )
            // Container(decoration: BoxDecoration(border: Border.all(color:Colors.amber.shade200,width: 2 )),
            // height: 50,width: MediaQuery.sizeOf(context).width * 0.94),
            // Container(decoration: BoxDecoration(border: Border.all(color:Colors.amber.shade200,width: 2 )),
            // height: 50,width: MediaQuery.sizeOf(context).width * 0.94)
          ],
        ),
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
