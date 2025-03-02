// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
// import 'package:grocery_app/domain/products/model/product_reg_model.dart';
// import 'package:grocery_app/main.dart';
// import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';

// Widget _buildErrorMessage(String? message) {
//   return SliverToBoxAdapter(
//     child: Align(
//       alignment: Alignment.center,
//       child: Text(message ?? 'Something went wrong'),
//     ),
//   );
// }

// Widget _buildNoResultsWidget() {
//   return SliverToBoxAdapter(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Oops!!..sad no results",
//             style: TextStyle(fontSize: 27, color: Colors.black38),
//           ),
//         ),
//         Center(
//           child: Image.asset('assets/user/notFound3.png',
//               height: 250, width: 300),
//         ),
//       ],
//     ),
//   );
// }

// class ProductGrid extends StatelessWidget {
//   final List<ProductRegModel>? productList;
//   const ProductGrid({Key? key, this.productList}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverPadding(
//       padding: EdgeInsets.all(8),
//       sliver: SliverGrid(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 0.6,
//         ),
//         delegate: SliverChildBuilderDelegate(
//           (context, index) {
//             final product = productList?[index].products;
//             return InkWell(
//               child: Container(
//                 clipBehavior: Clip.hardEdge,
//                 decoration: BoxDecoration(
//                   color: Colors.amber.shade100,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     CachedNetworkImage(
//                       width: MediaQuery.of(context).size.width * 0.56,
//                       height: MediaQuery.of(context).size.height * 0.27,
//                       imageUrl: product?.image ?? '',
//                       fit: BoxFit.cover,
//                       errorWidget: (context, url, error) => Icon(
//                         Icons.error,
//                         size: 60,
//                         color: Colors.black45,
//                       ),
//                       placeholder: (context, url) => SpinKitPulse(
//                         color: Colors.white,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10, bottom: 4, top: 4),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product?.productName ?? '',
//                                   style: TextStyle(fontSize: 17, color: Colors.black),
//                                 ),
//                                 Text(
//                                   product?.productDescription ?? '',
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Text("Price: ${product?.price ?? ''}"),
//                               ],
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             CartModel cartItems = CartModel(
//                               id: product?.id ?? 0,
//                               prodName: product?.productName ?? '',
//                               price: product?.price ?? 0,
//                               url: product?.image ?? '',
//                             );

//                             bool itemExists = cartBox.values.any((item) => item.id == cartItems.id);

//                             if (!itemExists) {
//                               context.read<CartBloc>().add(CartItemAdd(cartItems: cartItems));
//                               cartitemsCount.value += 1;
//                               _showSnackBar(context, "Product added to cart!");
//                             } else {
//                               _showSnackBar(context, "Product already in cart!", isError: true);
//                             }
//                           },
//                           icon: Icon(Icons.shopping_cart),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//           childCount: productList?.length ?? 0,
//         ),
//       ),
//     );
//   }

//   void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         content: Text(
//           message,
//           style: TextStyle(color: isError ? Colors.red : Colors.black),
//         ),
//         duration: Duration(seconds: 1),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }
// }
