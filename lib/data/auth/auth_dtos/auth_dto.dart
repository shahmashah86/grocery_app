// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';

class AuthDto {
  final String? token;
  final String? name;
  final int? id;
  final String? userName;
  final String? email;
  final bool? isAdmin;
  final String? phoneNumber;
  final String? profileImage;

  
  const AuthDto({
    this.token,
    required this.name,
    required this.id,
    required this.email,
    required this.isAdmin,
  this.userName,
    this.phoneNumber,
   this.profileImage,

  });


  factory AuthDto.fromJson(dynamic json) {
    return AuthDto(
      token: json['token']??'',
      name: json['name'],
      userName:json['userName']??'',
      
      id: json['id'],
      email: json['email'],
      isAdmin: json['isAdmin'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage']??'',
      
    );
  }
//   factory AuthDto.fromJson(Map<String, dynamic> json) {
//   return AuthDto(
//      token: json['token']??'',
//     name: json['name'] ?? "",
//     email: json['email'] ?? "",
//     userName:json['userName']??'',
//     phoneNumber: json['phoneNumber']?.toString() ?? "",
//     profileImage: json['profileImage'] ?? "",
//     isAdmin: json['isAdmin'] ?? false,
//     id: json['id'] ?? 0,
//   );
// }


  AuthModel toModel() {
    return AuthModel(
        name: name,
        id: id,
        email: email,
        isAdmin: isAdmin,
       username: userName,
        phoneNumber: phoneNumber,
        image: profileImage);
  }



  

}
