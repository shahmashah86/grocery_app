import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/common/category/model/category_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Productcreate extends StatefulWidget {
  final ProductButtonMode buttonMode;
  final ProductRegModel? productToEdit;
  final int? productIdToupdate;
  const Productcreate(
      {super.key,
      this.productToEdit,
      required this.buttonMode,
      this.productIdToupdate});

  @override
  State<Productcreate> createState() => _ProductcreateState();
}

class _ProductcreateState extends State<Productcreate> {
   final logformkey = GlobalKey<FormState>();
 final ValueNotifier<File?> _image=ValueNotifier<File?>(null);
  late String productnameofImage;
  late int? idFromApi;
  late TextEditingController prodnameController;
  late TextEditingController prodDescController;
  late TextEditingController prodPriceController;
  late TextEditingController prodUnitController;
  late TextEditingController prodQtyController;
  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryGet());
    prodnameController = TextEditingController();
    prodDescController = TextEditingController();
    prodPriceController = TextEditingController();
    prodUnitController = TextEditingController();
    prodQtyController = TextEditingController();

    if (widget.productToEdit != null) {
      widget.buttonMode == ProductButtonMode.edit;
      log(widget.productToEdit!.products.id.toString(), name: 'id');

      prodnameController.text =
          widget.productToEdit?.products.productName ?? '';
      prodDescController.text =
          widget.productToEdit?.products.productDescription ?? '';
      prodPriceController.text =
          widget.productToEdit?.products.price.toString() ?? '';
      prodUnitController.text = widget.productToEdit?.products.unit ?? '';
      prodQtyController.text =
          widget.productToEdit?.products.stockQuantity.toString() ?? '';
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    prodnameController.dispose();
    prodPriceController.dispose();
    prodDescController.dispose();
    prodQtyController.dispose();
    prodUnitController.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  // File? _image;

  Future getImage() async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

    // setState(()  {
      _image.value = File(imageFile!.path);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if(widget.buttonMode==ProductButtonMode.edit){
    //     // ValueNotifier<List<String>> isselectedcategory = ValueNotifier([]);
    // ValueNotifier<bool> isAvailable = ValueNotifier(widget.productToEdit!.products.isAvailable);
    // ValueNotifier<bool> isTrending = ValueNotifier(widget.productToEdit!.products.isTrending);
    // List<int> seletedid = widget.productToEdit!.categories;

    // }
    // else{
    ValueNotifier<List<String>> isselectedcategory = ValueNotifier([]);
    ValueNotifier<bool> isAvailable = ValueNotifier(false);
    ValueNotifier<bool> isTrending = ValueNotifier(false);
    List<int> seletedid = [];
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade100,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            Form(key: logformkey,
              child: Column(
                spacing: 15,
                children: [
                  TextFormField(
                    controller: prodnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Empty field';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Product name",
                        filled: true,
                        // fillColor: Colors.amber.shade50,
                           border: InputBorder.none,
                        // hintText: "Product Name",
                        // hintStyle: TextStyle(color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder()),
                  ),
                  TextFormField(
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Empty field';
                      }
                      return null;
                    },
                    controller: prodDescController,
                    decoration: InputDecoration(labelText: "Description",
                        filled: true,
                        // fillColor: Colors.white,
                     border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder()),
                  ),
                  TextFormField(inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      else if(!RegExp(r'^\d*\.?\d*$').hasMatch(value)){
                        return 'Enter a valid number';
              
              
                      }
                      return null;
                    },
                    controller: prodPriceController,
                    decoration: InputDecoration(labelText: "Price",
                        filled: true,
                        // fillColor: Colors.amber.shade50,
                          border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder()),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                    controller: prodUnitController,
                    
                    decoration: InputDecoration(labelText: "Unit",
                        filled: true,
                        // fillColor: Colors.amber.shade50,
                      border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder()),
                  ),
                  TextFormField(inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      else if(int.parse(value)<0)
                      {
                       return 'Please enter a  valid quantity';
                      }
                      return null;
                    },
                    controller: prodQtyController,
                    
                    decoration: InputDecoration(labelText: 'Quantity',
                        filled: true,
                              
                        // fillColor: Colors.amber.shade50,
                          border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder()
                        ),
                  ),
                 
                  ValueListenableBuilder(
                      valueListenable: isAvailable,
                      builder: (context, value, _) {
                        return Container(
                          height: MediaQuery.sizeOf(context).height * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber.shade200),
                              color: const Color.fromARGB(200, 225, 215, 215)),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Row(children: [
                              Text(
                                "Available?",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 17),
                              ),
                              Spacer(),
                              Checkbox(
                                  value: isAvailable.value,
                                  onChanged: (value) {
                                    isAvailable.value = value!;
                                  })
                            ]),
                          ),
                        );
                      }),
                  ValueListenableBuilder(
                      valueListenable: isTrending,
                      builder: (context, value, _) {
                        return Container(
                          height: MediaQuery.sizeOf(context).height * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber.shade200),
                              color: const Color.fromARGB(200, 225, 215, 215)),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Row(children: [
                              Text(
                                "Trending?",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 17),
                              ),
                              Spacer(),
                              Checkbox(
                                  value: isTrending.value,
                                  onChanged: (value) {
                                    isTrending.value = value!;
                                  })
                            ]),
                          ),
                        );
                      }),
                  Container(
                    width: double.infinity,
                     height: MediaQuery.sizeOf(context).height * .06,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber.shade200),
                        borderRadius: BorderRadius.circular(10),
                        color:const Color.fromARGB(200, 225, 215, 215)),
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryLoaded) {
                          List<CategoryModel>? category = state.categoryList;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * .57,
                                 
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ValueListenableBuilder(
                                      valueListenable: isselectedcategory,
                                      builder: (context, value, child) {
                                        log(isselectedcategory.value.toString());
                                          
                                        return isselectedcategory.value.isNotEmpty
                                            ? Row(
                                                spacing: 3,
                                                children: isselectedcategory.value
                                                    .map((e) => Chip(
                                                          label: Text(e),
                                                          deleteIcon:
                                                              Icon(Icons.close),
                                                          onDeleted: () {
                                                            isselectedcategory
                                                                    .value =
                                                                List.from(
                                                                    isselectedcategory
                                                                        .value)
                                                                  ..remove(e);
                                          
                                                            int categoryId = category!
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .name ==
                                                                        e)
                                                                .id;
                                                            seletedid = seletedid
                                                              ..remove(
                                                                  categoryId);
                                                            log(
                                                                seletedid
                                                                    .toString(),
                                                                name:
                                                                    'selected category id');
                                          
                                                            log(
                                                                isselectedcategory
                                                                    .value
                                                                    .toString(),
                                                                name:
                                                                    'selected categeory');
                                                          },
                                                        ))
                                                    .toList(),
                                              )
                                            : Text("select categeory");
                                      },
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                DropdownButton(
                                    menuWidth: double.infinity,
                                    alignment: Alignment.centerRight,
                                    icon: Icon(Icons.arrow_drop_down),
                                    items: category!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.name),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      int newValue = value!;
                                      if (!seletedid.contains(newValue) &&
                                          newValue != null) {
                                        seletedid.add(newValue);
                                      }
                                      String? categoryname = category
                                          .firstWhere(
                                              (element) => element.id == newValue)
                                          .name;
                                      if (categoryname != null ||
                                          categoryname == '') {
                                        if (!isselectedcategory.value
                                            .contains(categoryname)) {
                                          log(categoryname.toString());
                                          
                                          log(seletedid.toString());
                                          isselectedcategory.value =
                                              List.from(isselectedcategory.value)
                                                ..add(categoryname);
                                        }
                                        return;
                                      }
                                          
                                      log(seletedid.toString());
                                      log(isselectedcategory.value.toString());
                                    }),
                              ],
                            ),
                          );
                        }
                        return Text("Select a category");
                      },
                    ),
                  ),
                            Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ValueListenableBuilder(valueListenable: _image,
                    builder: (context, value, child) => 
                       Container(
                        height: MediaQuery.sizeOf(context).height * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.amber.shade200),
                            color: const Color.fromARGB(200, 225, 215, 215)),
                        child: _image.value == null
                            ? InkWell(
                                onTap: () {
                                  getImage();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Upload",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Icon(
                                      Icons.upload,
                                      color: Colors.black54,
                                    )
                                  ],
                                ))
                            : Image.file(
                                _image.value!,
                                fit: BoxFit.cover,
                                height: 200,
                                width: 100,
                              ),
                      ),
                    ),
                  ),
              
              
                  BlocListener<ProductBloc, ProductState>(
                    listener: (context, state) {
                      log('inside bloc listener');
              
                      if (state is ProductLoaded && state.isLoading==false) {
                   
                     
                        log("inside success state");
              
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
              
                      if (state is ProductError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.amber.shade200,
                            content: Text('Something wrong! pleass try again'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber.shade400),
                          color: Colors.amber.shade100),
                      child: TextButton(
                        onPressed: () {
                          if(logformkey.currentState!.validate()){
                            
                          productnameofImage=prodnameController.text.trim();
              
                          ProductsModel product = ProductsModel(
                            productName: prodnameController.text.trim(),
                            price: double.parse(prodPriceController.text.trim()),
                            productDescription: prodDescController.text.trim(),
                            stockQuantity:
                                double.parse(prodQtyController.text.trim()),
                            unit: prodUnitController.text.trim(),
                            isAvailable: isAvailable.value,
                            isTrending: isTrending.value,
                        
                          );

                          
                    
              
                          if (widget.buttonMode == ProductButtonMode.add) {
                            ProductRegModel products = ProductRegModel(
                                products: product, categories: seletedid);
                            context
                                .read<ProductBloc>()
                                .add(ProductRegistration(products:products,imageFile:_image.value));
                          }
                          if (widget.buttonMode == ProductButtonMode.edit) {
                            // if (widget.productIdToupdate != null) {
                            log('fghjk');
                            ProductRegModel products = ProductRegModel(
                                products: product, categories: seletedid);
                            context.read<ProductBloc>().add(productUpdation(
                                productsToUpdate: products,
                                idToUpdate: widget.productIdToupdate!));
                            
                            Navigator.pop(context);
                          }
              
                          Future.delayed(Duration(seconds: 2));
                          prodnameController.clear();
                          prodPriceController.clear();
                          prodDescController.clear();
                          prodQtyController.clear();
                          prodUnitController.clear();
                          isAvailable.value = false;
                          isTrending.value = false;
                          _image.value=null;
              
                          isselectedcategory.value.clear();
                          }
                        },
                        
                        child: Center(
                            child: Text(
                          widget.buttonMode == ProductButtonMode.add
                              ? "submit"
                              : "Edit",
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                  )
                  //             , Padding(
                  //   padding: const EdgeInsets.all(9.0),
                  //   child: Container(
                  //     height: MediaQuery.sizeOf(context).height * 0.14,
                  //     width: MediaQuery.sizeOf(context).width * 0.6,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: Colors.amber.shade200),
                  //         color: Colors.amber.shade50),
                  //     child: _image == null
                  //         ? InkWell(
                  //             onTap: () {
                  //               getImage();
                  //             },
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                   "Upload",
                  //                   style: TextStyle(color: Colors.black54),
                  //                 ),
                  //                 Icon(
                  //                   Icons.upload,
                  //                   color: Colors.black54,
                  //                 )
                  //               ],
                  //             ))
                  //         : Image.file(
                  //             _image!,
                  //             fit: BoxFit.cover,
                  //             height: 200,
                  //             width: 100,
                  //           ),
                  //   ),
                  // ),
                    //           TextButton(onPressed: (){
                    
                    // context.read<ProductBloc>().add(ProductimageUpload(productName:productnameofImage , idofImage: 125, imageFile: _image));
              
              
                    //           }, child: Text("Upload"))
              
                ],
              ),
            )
          ])),
    );
  }
}


