import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';

import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/product/product_description.dart';
import 'package:grocery_app/presentation/screens/admin/product/productcreate.dart';
import 'package:grocery_app/presentation/screens/admin/widgets/product_content.dart';
import 'package:grocery_app/presentation/screens/authentication/registration.dart';
import 'package:image_picker/image_picker.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ValueNotifier<File?> _image = ValueNotifier<File?>(null);
  late final TextEditingController searchController;

  @override
  void didChangeDependencies() {
    // context.read<ProductBloc>().add(ProductList());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
     searchController=TextEditingController();
  }

  final ImagePicker _picker = ImagePicker();
  // File? _image;

  Future getImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    // setState(()  {
    _image.value = File(imageFile!.path);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Productcreate(buttonMode: ProductButtonMode.add);
                  }));
                },
                icon: Icon(Icons.add)),
          ],
          backgroundColor: Colors.amber.shade200,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: TextField(controller: searchController,
                onChanged: (value) {
                
                  context.read<ProductBloc>().add(Productsearch(productName: searchController.text.trim()));


                },
                decoration: InputDecoration(
                  fillColor: Colors.amber.shade50,
                  filled: true,
                  hintText: "Search",
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber))
                ),
              ),
            ),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductLoaded) {
                  if (state.message == 'Product deleted successfully') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.lime,
                        content: Text(
                          'product deleted succesfully',
                          style: TextStyle(color: Colors.black87),
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  if (state.message == 'Product is updated successfully') {
                    log("inside success state", name: 'product create screen');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.lime,
                        content: Text(
                          style: TextStyle(color: Colors.black87),
                          'Products updated successfully!',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    // context.read<ProductBloc>().add(ProductList());
                  }
                  if(state.isError){
                    if( state.mode == ProdCreateEditScreen.edit){
                          ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          style: TextStyle(color: Colors.white),
                          state.errormsg.toString(),
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                     
                    }
                 
                 
                  }
                
                }
              },
              builder: (context, state) {
                if (state is ProductLoading) {
                  log("loading", name: 'productlist screen');
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ProductLoaded) {
                  if (state.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.isError &&
                      state.mode == ProdCreateEditScreen.list) {
                           if(state.errormsg=='Exception: Please provide a product name to search'){
                        if(state.productList?.isEmpty??true){
                             return Center(child: Text("Empty product list"));
                        }
                        else{
                      return ProductContent(products:state.productList! );
                        }
                    }
                    return Center(
                      child: Text(state.errormsg.toString()),
                    );
                  }
                  if (state.productList?.isEmpty ?? true) {
                    return Center(
                      child: Text("Product list is empty"),
                    );
                  }
                  // log('listview from productlist screen');

                  if (state.productList?.isNotEmpty ?? false) {
                    if(state.frombottomnav){
                    List<ProductRegModel> products = state.productList!;
                    // log(products.toString());
                    return ProductContent(products: products);

                    
                    }
                  }
                  if(state.searchList?.isNotEmpty??false){
                    if(state.frombottomnav==false){
                     List<ProductRegModel>? searchlist = state.searchList!;
                     return ProductContent(products: searchlist);
                    }

                  }
                  if(state.searchList?.isEmpty??true)
                  {
                       return Center(child: Text("search result is empty"),);
                  }
                }

                if (state is ProductError) {
                  return Center(
                    child: Text(state.msg.toString()),
                  );
                }
                return Text("please wait or try again");
              },
            ),
          ],
        ));
  }
}
