// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String? name;
  final int? id;
  final String? email;
  final bool? isAdmin;
  final String? phoneNumber;
  final String? image;
  final String? username;
  
  const AuthModel({
    this.username,
    this.name,
    this.id,
    this.email,
    this.isAdmin,
    this.phoneNumber,
    this.image,
   
  });

  @override
  String toString() {

    return 'AuthModel(username:$username,name:$name,id:$id,email:$email,phoneNummber:$phoneNumber,profileImage:$image)';
  }

  @override

  List<Object?> get props => [username,name, id, email, isAdmin, phoneNumber, image];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
   'id': id,
      'name': name,
               'userName':username,
   
      'email': email,
      'isAdmin': isAdmin,
      'phoneNumber': phoneNumber,
      'image': image,
   
    };
  }


  
}
