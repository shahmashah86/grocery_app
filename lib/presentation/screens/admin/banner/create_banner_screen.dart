import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/admin/dasboard/dtos/admin_dasboard_dto.dart';
import 'package:grocery_app/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateBannerScreen extends StatefulWidget {
  CreateBannerScreen({super.key});

  @override
  State<CreateBannerScreen> createState() => _CreateBannerScreenState();
}

class _CreateBannerScreenState extends State<CreateBannerScreen> {
  final ImagePicker _picker = ImagePicker();


ValueNotifier<List<File>> selectedImages=ValueNotifier([]);



  Future getImage() async {
    final pickedFile =  await _picker.pickMultiImage();
     List<XFile> xfilePick = pickedFile;
    
    if(xfilePick.isNotEmpty){
      for (var i = 0; i < xfilePick.length; i++) {
 
        selectedImages.value = List.from(selectedImages.value)..add(File(xfilePick[i].path));
          }
       


    }
    
    
   
    
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber.shade200,actions: [IconButton(onPressed: () async{
      await  getImage();
    // log(banners.toString());
      


        
        
        
        }, icon: Icon(Icons.add_a_photo,),iconSize: 30,)],),

      body:
             ValueListenableBuilder(valueListenable: selectedImages,
       builder: (context, value, child) => 
      selectedImages.value.isEmpty?
       Center(child:Text("No image selected")):
      
         Column(
           children: [
             Expanded(
               child: ListView.builder(
                itemBuilder: (context, index) {
                  return Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                      
                      
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.amber.shade50,image: DecorationImage(image: FileImage(selectedImages.value[index],),fit: BoxFit.cover)),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: IconButton(onPressed: (){
                     selectedImages.value= List.from(selectedImages.value)..removeAt(index);
                    
                      },
                      icon:  Icon(
                          Icons.delete,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]);
                },
                itemCount: selectedImages.value.length
                     ),
             ),
                   TextButton(onPressed: (){
                log(selectedImages.value.toString());
                      context.read<AdminDashboardBloc>().add(AdminbannerCreation(imageFile: selectedImages.value));
               }, child: Text("upload"))
           ],
         )
    
       )
    );
  }
}
