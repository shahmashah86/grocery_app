

import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/screens/admin/orders/all_orders_screen.dart';


class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> userdetails = [
      {
        "Name": "Rasha",
        "username": "Rasha121",
        "Password": "2332223",
        "email": "redrggga223@eegmail.com"
      },
      {
        "Name": "Rasha",
        "username": "Rasha121",
        "Password": "2332223",
        'PhoneNo': "44444444444",
        "email": "redrggga223@eegmail.com"
      },
      {
        "Name": "Rasha",
        "username": "Rasha121",
        "Password": "2332223",
        'PhoneNo': "44444444444",
        "email": "redrggga223@eegmail.com"
      },
      {
        "Name": "Rasha",
        "username": "Rasha121",
        "Password": "2332223",
        'PhoneNo': "44444444444",
        "email": "redrggga223@eegmail.com"
      },
      {
        "Name": "Rasha",
        "username": "Rasha121",
        "Password": "2332223",
        'PhoneNo': "44444444444",
        "email": "redrggga223@eegmail.com"
      },
      {
        "Name": "Rasha",
        "username": "Rasha121",
        "Password": "2332223",
        'PhoneNo': "44444444444",
        "email": "redrggga223@eegmail.com"
      },
      {
        "Name": "Rasha",
        "username": "Rasha121",
        "Password": "2332223",
        'PhoneNo': "44444444444",
        "email": "redrggga223@eegmail.com"
      }
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: ListView.builder(
        itemCount: userdetails.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.amber.shade100,
                    Colors.amber.shade50,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.lime)),
              child: ListTile(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return AllOrders();}));},
              
                  leading: CircleAvatar(radius: 40,foregroundImage: AssetImage("assets/banner/person.jpg")
                  ),
                  minTileHeight: 100,
                  minVerticalPadding: 20,
                  title: Text(
                    userdetails[index]["Name"]!,
                    style: TextStyle(fontSize: 19),
                  ),
                  subtitle: Text(userdetails[index]["email"]!,
                      style: TextStyle(fontSize: 16)),
                  contentPadding: EdgeInsets.all(10),
       
                  ),
            ),
          );
        },
      ),
    );
  }
}
