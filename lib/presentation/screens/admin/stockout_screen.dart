import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';

class StockoutScreen extends StatelessWidget {
  StockoutScreen({super.key});

  // ValueNotifier to track if sorting is ascending
  ValueNotifier<bool> isSortAsc = ValueNotifier(true);


    List<ProductsModel>? stocks;

  // ValueNotifier managing the current stock displayed in the table
  final ValueNotifier<List<ProductsModel>?> stock =
      ValueNotifier<List<ProductsModel>>([]);

  // A ValueNotifier to track the sorted column index
  final ValueNotifier<int?> currentSortColumnIndex = ValueNotifier<int?>(null);
  final ValueNotifier<bool> isSorted = ValueNotifier<bool>(false);
  // bool isSorted=false;

  @override
  Widget build(BuildContext context) {
    // Initialize the stock data with the original stock initially..
  

    return Scaffold(
      appBar: AppBar(
        actions: [
          ValueListenableBuilder(
            valueListenable: isSorted,
            builder: (context, value, child) => isSorted.value == false
                ? Icon(
                    Icons.play_arrow,
                    color: Colors.transparent,
                  )
                : TextButton(
                  onPressed: () {
  log(isSorted.value.toString());

  stock.value = List.from(stocks!); // Restore the original list
  isSortAsc.value = true; // Reset sorting order to ascending
  currentSortColumnIndex.value = null; // Clear sorted column index
  isSorted.value = false; // Mark as unsorted
},

               
                    child: Text("Reset"),
                  ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
          iconSize: 30,
        ),
         backgroundColor: Colors.amber.shade200,
        title: const Text("Inventory details"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
       
     
        
        builder: (context, state) {
          if(state is ProductLoading){
            return CircularProgressIndicator();
          }
             if(state is ProductLoaded){
                stocks = List.from(state.stockList!); // Keep original data into stocks
  stock.value = List.from(stocks!); // Initialize stock with fresh unsorted data
            // stocks= state.stockList;
            //   stock.value = stocks??[];
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<List<ProductsModel>?>(
                    valueListenable: stock,
                    builder: (context, currentStock, child) {
                      return ValueListenableBuilder<bool>(
                        valueListenable: isSortAsc,
                        builder: (context, isAscending, _) {
                          return DataTable(
                            sortColumnIndex: currentSortColumnIndex.value,//to show ths filter icon on column only when needed
                            sortAscending: !isAscending,//show the arrow in ascending or descending
                            headingRowColor: WidgetStateColor.resolveWith(
                                (states) => Colors.amber.shade50),
                            columns: [
                              const DataColumn(
                                label: Text(
                                  "Product",
                                  style: TextStyle(color: Colors.indigo,fontSize: 19),
                                ),
                              ),
                              DataColumn(
                                label: Row(
                                  children: [
                                    const Text(
                                      "Quantity",
                                      style: TextStyle(color: Colors.indigo,fontSize: 19),
                                    ),
                                  ],
                                ),
                                onSort: (columnIndex, _) {
  if (columnIndex == 1) {
    // Make a new sorted copy (without modifying original data)
    List<ProductsModel> sortedList = List.from(stock.value!);

    sortedList.sort((a, b) {
      return isSortAsc.value
          ? a.stockQuantity!.compareTo(b.stockQuantity!)
          : b.stockQuantity!.compareTo(a.stockQuantity!);
    });

    isSortAsc.value = !isSortAsc.value; // Toggle sorting order
    currentSortColumnIndex.value = columnIndex; // Set sorted column index
    stock.value = List.from(sortedList); // Explicitly update stock
    isSorted.value = true; // Mark sorting as applied
  }
},

                            
                              ),
                            ],
                            rows: currentStock!.map((element) {
                              return DataRow(color:element.stockQuantity!<10?WidgetStatePropertyAll(Colors.red.shade400):WidgetStatePropertyAll(Colors.green.shade300),
                                cells: [
                                  DataCell(Text(element.productName ?? "",style: TextStyle(color: element.stockQuantity!<10?Colors.white:Colors.black)),),
                                  DataCell(Text(
                                    element.stockQuantity.toString(),
                                    style: TextStyle(fontSize: 17,color: element.stockQuantity!<10?Colors.white:Colors.black),
                                  )),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
             }
             if(state is ProductError){
              return Text(state.msg.toString());
             }
             return Text("Loading");
        },
      ),
    );
  }
}
