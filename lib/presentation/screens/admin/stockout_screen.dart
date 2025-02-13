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

  // Original stock data
  // List<Map<String, dynamic>> originalStock = [
  //   {"Prodname": "Apple", "qty": 47},
  //   {"Prodname": "Orange", "qty": 387},
  //   {"Prodname": "Egg", "qty": 427},
  //   {"Prodname": "Ruled notebook", "qty": 17},
  //   {"Prodname": "Lays", "qty": 1},
  //   {"Prodname": "Lays", "qty": 17},
  //   {"Prodname": "Lays", "qty": 17},
  //   {"Prodname": "Lays", "qty": 17},
  //   {"Prodname": "Lays", "qty": 17},
  //   {"Prodname": "Lays", "qty": 17},
  // ];
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
                      // Reset stock to the original list
                      stock.value = stocks!;
                      isSortAsc.value =
                          true; // Reset sorting to ascending to maintain the ascending state while initial loading
                      currentSortColumnIndex.value = null; //column index
                      isSorted.value = false;
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
        backgroundColor: Colors.amber.shade100,
        title: const Text("Inventory details"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
       
     
        
        builder: (context, state) {
             if(state is ProductLoaded){
            stocks= state.stockList;
              stock.value = stocks??[];
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
                            sortColumnIndex: currentSortColumnIndex.value,
                            sortAscending: isAscending,
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
                                  // Sorting logic
                                  if (columnIndex == 1) {
                                    if (isAscending) {
                                      currentStock!.sort((a, b) =>
                                          a.stockQuantity!.compareTo(b.stockQuantity as double));
                                    } else {
                                      currentStock!.sort((a, b) =>
                                          b.stockQuantity!.compareTo(a.stockQuantity as double));
                                    }
                                    isSortAsc.value =
                                        !isAscending; // pressing toggle the sorting order to ascending and descending viceversa
                                    currentSortColumnIndex.value =
                                        columnIndex; // Update the sorted column
                                    stock.value = List.from(currentStock);
                                    // Notify the changes
                                    isSorted.value = true;
                                    log(isSorted.toString());
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
             return Text("Loading");
        },
      ),
    );
  }
}
