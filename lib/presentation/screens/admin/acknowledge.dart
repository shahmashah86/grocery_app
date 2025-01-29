import 'package:flutter/material.dart';

class Acknowledge extends StatelessWidget {
 Acknowledge({super.key});

  @override
  Widget build(BuildContext context) {
    
ValueNotifier<bool> acknowledged=ValueNotifier(false);
    return Scaffold(appBar: AppBar(backgroundColor: Colors.amber.shade200,),body:
    
   ListView.separated(itemBuilder: (context,intdex){
      return ListTile(tileColor: Colors.amber.shade50,minTileHeight: 90,
        title: Column(
        children: [
          Row(spacing: 10,
            children: [ Text("User Id:"),
              Text("234"),
            ],
          ),
           Row(spacing: 10,
            children: [ Text("Order Id:"),
              Text("4434"),
            ],
          ),

        ],
      ),trailing: ValueListenableBuilder(valueListenable: acknowledged,builder: (context, value, child) => 
       acknowledged.value==false? TextButton(onPressed: (){
          acknowledged.value=true;
        }, child: Text("Approve")):Text("Approved",style: TextStyle(color: Colors.green,fontSize: 15),)
      ),);

    }
    , separatorBuilder: (context,index){return Container(color: Colors.amber.shade100,height: 10,);}, itemCount: 45) );
  }
}