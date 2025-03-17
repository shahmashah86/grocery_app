import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/screens/user/product_description/product_description.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductRegModel>? productdetail;
  // final bool? bySearch;
  const ProductGrid({super.key, this.productdetail,});

  @override
  Widget build(BuildContext context) {
    log('pro');
    log(productdetail.toString(), name: 'from productgrid');
    return SliverPadding(
      padding: EdgeInsets.all(8),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.61,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductDescription();
                }));

                context.read<ProductBloc>().add(
                    Productget(productId: productdetail![index].products.id!));
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // bySearch == true
                    //     ?
                        //for showing available and unailable image
                        productdetail![index].products.isAvailable == true
                            ? CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.56,
                                height: 200,
                                imageUrl:
                                    productdetail?[index].products.image ?? '',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 60,
                                  color: Colors.black45,
                                ),
                                placeholder: (context, url) => SpinKitPulse(
                                  color: Colors.white,
                                ),
                              )
                            : Stack(
                                children: [
                                  CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                    height: 200,
                                    imageUrl:
                                        productdetail?[index].products.image ??
                                            '',
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 40,
                                    ),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => SpinKitPulse(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                    height: 200,
                                    color: Colors.white.withOpacity(
                                        0.8), // Light overlay effect on the image
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    left: 22,
                                    child: Text(
                                      'unavailable',
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // : CachedNetworkImage(
                        //     width: MediaQuery.of(context).size.width * 0.56,
                        //     height: 200,
                        //     imageUrl:
                        //         productdetail![index].products.image ?? '',
                        //     errorWidget: (context, url, error) => Icon(
                        //       Icons.image_not_supported_outlined,
                        //       size: 40,
                        //     ),
                        //     fit: BoxFit.cover,
                        //     placeholder: (context, url) => SpinKitPulse(
                        //       color: Colors.white,
                        //     ),
                        //   ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 2, top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productdetail?[index].products.productName ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                // Text(
                                //   productdetail?[index].products.productDescription ??
                                //       '',
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                Text(
                                    "₹: ${productdetail?[index].products.price ?? ''}"),
                                productdetail?[index].products.stockQuantity ==
                                        0
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.warning,size: 14,
                                            color: Colors.red,
                                          ),
                                          Text('stockout',style: TextStyle(color:Colors.red),),
                                        ],
                                      )
                                    : SizedBox.shrink()
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (productdetail?[index].products.isAvailable ==
                                    true &&
                                productdetail?[index].products.stockQuantity !=
                                    0) {
                              CartModel cartItems = CartModel(
                                id: productdetail?[index].products.id ?? 0,
                                prodName: productdetail?[index]
                                        .products
                                        .productName ??
                                    '',
                                price:
                                    productdetail?[index].products.price ?? 0,
                                url: productdetail?[index].products.image ?? '',
                              );

                              bool itemExists = cartBox.values
                                  .any((item) => item.id == cartItems.id);

                              if (!itemExists) {
                                context
                                    .read<CartBloc>()
                                    .add(CartItemAdd(cartItems: cartItems));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.lime,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Text(
                                      "Product added to cart!",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Text(
                                      "Product already in cart!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Text(
                                    "Product is currently unavailable!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  duration: Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: productdetail?.length ?? 0,
        ),
      ),
    );
  }
}
