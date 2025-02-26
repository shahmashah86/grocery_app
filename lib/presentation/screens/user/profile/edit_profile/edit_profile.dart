import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String? phoneNumber;
  final String? email;
  final bool toEdit;
  const EditProfile({super.key,this.phoneNumber,this.email,this.toEdit=false});
  

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
      TextEditingController phoneNumbercontroller=TextEditingController();
         TextEditingController emailController=TextEditingController();
  @override
  void initState() {
    phoneNumbercontroller.text=widget.phoneNumber??'';
        emailController.text=widget.email??'';
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 248, 237, 202).withOpacity(0.4),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.amber.shade100), color: Colors.white),
          width: MediaQuery.of(context).size.width * 0.88,
          height: MediaQuery.of(context).size.height * 0.62,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              spacing: 25,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                Container(decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.amber.shade200, width: 2)),
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.94, child: TextFormField(controller: phoneNumbercontroller,)),
                Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.amber.shade200, width: 2)),
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.94
                    ,child: TextFormField(controller: emailController,),
                    ),
                Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.amber.shade200, width: 2)),
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.94,
                    child: TextFormField(),
                    ),
                Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.amber.shade200, width: 2)),
                
                    width: MediaQuery.sizeOf(context).width * 0.94,
                    child: TextField(decoration: InputDecoration(border:InputBorder.none ),
                      maxLines: 5,
                      readOnly: true,
                      
                    )),
                    widget.toEdit==true?
                    ElevatedButton(onPressed: (){

                    }, child: Text("save")):Text('')

              ],
            ),
          ),
        ),
      ),
    );
  }
}
