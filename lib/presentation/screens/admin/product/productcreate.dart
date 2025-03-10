import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/domain/category/model/category_model.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class Productcreate extends StatefulWidget {
  final ProductButtonMode buttonMode;
  final ProductRegModel? productToEdit;
  final int? productIdToupdate;
  final String? productimage;
  const Productcreate(
      {super.key,
      this.productToEdit,
      required this.buttonMode,
      this.productIdToupdate,
      this.productimage});

  @override
  State<Productcreate> createState() => _ProductcreateState();
}

class _ProductcreateState extends State<Productcreate> {
  final logformkey = GlobalKey<FormState>();
  final ValueNotifier<File?> _image = ValueNotifier<File?>(null);

  late int? idFromApi;
  late TextEditingController prodnameController;
  late TextEditingController prodDescController;
  late TextEditingController prodPriceController;
  late TextEditingController prodUnitController;
  late TextEditingController prodQtyController;
  late bool isAvailableStaus = false;
  late bool isTrendingStatus = false;
  late final MultiSelectController controller;
  late List<int> selectedItemstoEdit = [];
  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryGet());
    prodnameController = TextEditingController();
    prodDescController = TextEditingController();
    prodPriceController = TextEditingController();
    prodUnitController = TextEditingController();
    prodQtyController = TextEditingController();
    controller = MultiSelectController();

    if (widget.productToEdit != null) {
      widget.buttonMode == ProductButtonMode.edit;
      log(widget.productToEdit.toString(), name: 'id');

      prodnameController.text =
          widget.productToEdit?.products.productName ?? '';
      prodDescController.text =
          widget.productToEdit?.products.productDescription ?? '';
      prodPriceController.text =
          widget.productToEdit?.products.price.toString() ?? '';
      prodUnitController.text = widget.productToEdit?.products.unit ?? '';
      prodQtyController.text =
          widget.productToEdit?.products.stockQuantity.toString() ?? '';
      isAvailableStaus = widget.productToEdit?.products.isAvailable ?? false;
      isTrendingStatus = widget.productToEdit?.products.isTrending ?? false;
      selectedItemstoEdit = widget.productToEdit!.categories;
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

  Future getImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    _image.value = File(imageFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    final controller = MultiSelectController<CategoryModel>();

    ValueNotifier<List<String>> isselectedcategory = ValueNotifier([]);

    ValueNotifier<bool> isAvailable =
        ValueNotifier(isAvailableStaus ? true : false);
    ValueNotifier<bool> isTrending =
        ValueNotifier(isTrendingStatus ? true : false);
    List<int> seletedid = [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Registration"),
        backgroundColor: Colors.amber.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: ListView(children: [
          SizedBox(
            height: 10,
          ),
          Form(
            key: logformkey,
            child: Column(
              spacing: 18,
              children: [
                TextFormField(
                  controller: prodnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Empty field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Product name",
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
                  decoration: InputDecoration(
                      labelText: "Description",
                      filled: true,
                      // fillColor: Colors.white,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber.shade200),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder()),
                ),
                TextFormField(
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
                  // ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    } else if (!RegExp(r'^\d*\.?\d*$').hasMatch(value)) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                  controller: prodPriceController,
                  decoration: InputDecoration(
                      labelText: "Price",
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
                  decoration: InputDecoration(
                      labelText: "Unit",
                      filled: true,
                      // fillColor: Colors.amber.shade50,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber.shade200),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder()),
                ),
                TextFormField(
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    } else if (double.parse(value) < 0) {
                      return 'Please enter a  valid quantity';
                    }
                    return null;
                  },
                  controller: prodQtyController,
                  decoration: InputDecoration(
                      labelText: 'Quantity',
                      filled: true,

                      // fillColor: Colors.amber.shade50,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber.shade200),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder()),
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
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      List<CategoryModel>? category = state.categoryList ?? [];
                      if (widget.productToEdit != null) {
                      
                      final List selectedIds = widget.productToEdit!.categories;
                      log(selectedIds.toString());

controller.selectWhere((item) => selectedIds.contains(item.value.id));

                        // final selectedIds = widget.productToEdit!.categories;
                        // for(int i in selectedIds){
                        // controller.selectWhere(
                        //   (item) {
                        //     if(item.value.id == 1
                        //     ){
                        //      return true;
                        //     }
                        //     else{
                        //       return false;
                        //     }
                        //   },
                        // );
                        // }
                      }
                      return MultiDropdown<CategoryModel>(
                        items: category
                            .map((toElement) => DropdownItem<CategoryModel>(
                                label: toElement.name, value: toElement))
                            .toList(),
                        controller: controller,
                        enabled: true,
                        searchEnabled: true,
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Colors.yellow,
                          wrap: true,
                          runSpacing: 2,
                          spacing: 10,
                        ),
                        fieldDecoration: FieldDecoration(
                          hintText: 'Choose categories',
                          hintStyle: const TextStyle(color: Colors.black87),
                          showClearIcon: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        dropdownDecoration: const DropdownDecoration(
                          marginTop: 2,
                          maxHeight: 500,
                          header: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Select categories from the list',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon:
                              const Icon(Icons.check_box, color: Colors.green),
                          disabledIcon:
                              Icon(Icons.lock, color: Colors.grey.shade300),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a country';
                          }
                          return null;
                        },
                      );
                    }
                    return MultiDropdown<Category>(items: []);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ValueListenableBuilder<File?>(
                    valueListenable: _image,
                    builder: (context, value, child) => Row(
                      spacing: 12,
                      children: [
                        Container(
                            clipBehavior: Clip.hardEdge,
                            height: MediaQuery.sizeOf(context).height * 0.14,
                            width: MediaQuery.sizeOf(context).height * 0.28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber.shade200),
                              color: const Color.fromARGB(200, 225, 215, 215),
                            ),
                            child: (_image.value == null)
                                ? (widget.productimage != null &&
                                        widget.productimage!.isNotEmpty)
                                    ? Image.network(
                                        widget.productimage!,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .2,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                          child: Text("Image not available"),
                                        ),
                                      )
                                    : null
                                : _image.value != null
                                    ? Image.file(
                                        _image.value!,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .2,
                                        width: 200,
                                      )
                                    : null),
                        InkWell(
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocListener<ProductBloc, ProductState>(
                  listener: (context, state) {
                    log('inside bloc listener');

                    if (state is ProductLoaded) {
                      if (state.message.isNotEmpty) {
                        Future.delayed(Duration(seconds: 2));
                        prodnameController.clear();
                        prodPriceController.clear();
                        prodDescController.clear();
                        prodQtyController.clear();
                        prodUnitController.clear();
                        isAvailable.value = false;
                        isTrending.value = false;
                        _image.value = null;

                        isselectedcategory.value.clear();
                        log("inside success state");

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.lime,
                            content: Text(
                              state.message,
                              style: TextStyle(color: Colors.black87),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      if (state.isError &&
                          state.mode == ProdCreateEditScreen.add) {
                        log("inside error state");

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              state.errormsg ??
                                  'something wrong while registering',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }

                    if (state is ProductError) {
                      log('product error');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            state.msg ?? 'Something wrong while registering',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ProductLoaded && state.isLoading) {
                        return SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.amber.shade400),
                            color: Colors.amber.shade100),
                        child: TextButton(
                          onPressed: () {
                            if (logformkey.currentState!.validate()) {
                              List<int> selectedIds = controller.selectedItems
                                  .map((e) => e.value.id)
                                  .toList();
                              log(selectedIds.toString(), name: 'selectedIds');

                              prodnameController.text.trim();

                              ProductsModel product = ProductsModel(
                                productName: prodnameController.text.trim(),
                                price: double.parse(
                                    prodPriceController.text.trim()),
                                productDescription:
                                    prodDescController.text.trim(),
                                stockQuantity:
                                    double.parse(prodQtyController.text.trim()),
                                unit: prodUnitController.text.trim(),
                                isAvailable: isAvailable.value,
                                isTrending: isTrending.value,
                              );

                              if (widget.buttonMode == ProductButtonMode.add) {
                                ProductRegModel products = ProductRegModel(
                                    products: product, categories: seletedid);
                                context.read<ProductBloc>().add(
                                    ProductRegistration(
                                        products: products,
                                        imageFile: _image.value));
                              }
                              if (widget.buttonMode == ProductButtonMode.edit) {
                                if (widget.productIdToupdate != null) {
                                  ProductRegModel products = ProductRegModel(
                                      products: product,
                                      categories: selectedIds);
                                  context.read<ProductBloc>().add(
                                      ProductUpdation(
                                          productsToUpdate: products,
                                          idToUpdate: widget.productIdToupdate!,
                                          imageFile: _image.value
                                          ));

                                  Navigator.pop(context);
                                }
                              }
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
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class Catetegory {
  final String name;
  final int id;

  Catetegory({required this.name, required this.id});

  @override
  String toString() {
    return 'Category(name: $name, id: $id)';
  }
}






 // Container(
                //   width: double.infinity,
                //   height: MediaQuery.sizeOf(context).height * .06,
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.amber.shade200),
                //       borderRadius: BorderRadius.circular(10),
                //       color: const Color.fromARGB(200, 225, 215, 215)),
                //   child: BlocBuilder<CategoryBloc, CategoryState>(
                //     builder: (context, state) {
                //       if (state is CategoryLoaded) {
                //         List<CategoryModel>? category = state.categoryList;
                //         return Padding(
                //           padding: const EdgeInsets.only(left: 3),
                //           child: Row(
                //             children: [
                //               SizedBox(
                //                 width: MediaQuery.sizeOf(context).width * .58,
                //                 child: SingleChildScrollView(
                //                   scrollDirection: Axis.horizontal,
                //                   child: ValueListenableBuilder(
                //                     valueListenable: isselectedcategory,
                //                     builder: (context, value, child) {
                //                       log(isselectedcategory.value
                //                           .toString(),);

                //                       return isselectedcategory
                //                               .value.isNotEmpty
                //                           ? Row(
                //                               spacing: 3,
                //                               children: isselectedcategory
                //                                   .value
                //                                   .map((e) => Chip(
                //                                         label: Text(e),
                //                                         deleteIcon:
                //                                             Icon(Icons.close),
                //                                         onDeleted: () {
                //                                           isselectedcategory
                //                                                   .value =
                //                                               List.from(
                //                                                   isselectedcategory
                //                                                       .value)
                //                                                 ..remove(e);

                //                                           int categoryId = category!
                //                                               .firstWhere(
                //                                                   (element) =>
                //                                                       element
                //                                                           .name ==
                //                                                       e)
                //                                               .id;
                //                                           seletedid = seletedid
                //                                             ..remove(
                //                                                 categoryId);
                //                                           log(
                //                                               seletedid
                //                                                   .toString(),
                //                                               name:
                //                                                   'selected category id');

                //                                           log(
                //                                               isselectedcategory
                //                                                   .value
                //                                                   .toString(),
                //                                               name:
                //                                                   'selected categeory');
                //                                         },
                //                                       ))
                //                                   .toList(),
                //                             )
                //                           : Text("select categeory");
                //                     },
                //                   ),
                //                 ),
                //               ),
                //               // Spacer(),
                //               SizedBox(      width: MediaQuery.sizeOf(context).width * 0.32,
                //                 child: DropdownButton(

                //                     alignment: Alignment.centerRight,
                //                     icon: Icon(Icons.arrow_drop_down),
                //                     items: category!
                //                         .map(
                //                           (e) => DropdownMenuItem(
                //                             value: e.id,
                //                             child: Text(e.name),
                //                           ),
                //                         )
                //                         .toList(),
                //                     onChanged: (value) {
                //                       int newValue = value!;
                //                       if (!seletedid.contains(newValue)) {
                //                         seletedid.add(newValue);
                //                       }
                //                       String? categoryname = category
                //                           .firstWhere((element) =>
                //                               element.id == newValue)
                //                           .name;
                //                       // ignore: unnecessary_null_comparison
                //                       if (categoryname != null ||
                //                           categoryname == '') {
                //                         if (!isselectedcategory.value
                //                             .contains(categoryname)) {
                //                           log(categoryname.toString());

                //                           log(seletedid.toString());
                //                           isselectedcategory.value = List.from(
                //                               isselectedcategory.value)
                //                             ..add(categoryname);
                //                         }
                //                         return;
                //                       }

                //                       log(seletedid.toString());
                //                       log(isselectedcategory.value.toString());
                //                     }),
                //               ),
                //             ],
                //           ),
                //         );
                //       }
                //       return Text("Select a category");
                //     },
                //   ),
                // ),