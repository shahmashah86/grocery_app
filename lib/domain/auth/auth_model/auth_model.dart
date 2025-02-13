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
  const AuthModel({
    this.name,
    this.id,
    this.email,
    this.isAdmin,
    this.phoneNumber,
    this.image,
  });

  @override
  String toString() {

    return 'AuthModel(name:$name,id:$id,email:$email,phoneNummber:$phoneNumber,profileImage:$image)';
  }

  @override

  List<Object?> get props => [name, id, email, isAdmin, phoneNumber, image];
}
