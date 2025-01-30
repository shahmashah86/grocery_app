// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {

final String? name;
final String? username;
final String? email;
final String? password;
final bool? isAdmin;
final String? phoneNumber;
final String? imageUrl;
  AuthModel({
   this.name,
    this.username,
   this.email,
  this.password,
    this.isAdmin,
    this.phoneNumber,
    this.imageUrl,
  });

@override
  String toString() {
    // TODO: implement toString
    return 'AuthModel(name:$name,username:$username,email:$email,password:$password,phoneNummber:$phoneNumber,imageUrl:$imageUrl)';

  }
  

  @override
  // TODO: implement props
  List<Object?> get props => [name, username,  email, password, isAdmin,phoneNumber,imageUrl];
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      name: map['name'] != null ? map['name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] as String,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }
