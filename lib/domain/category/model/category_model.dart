// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  int id;
  String name;
  CategoryModel({
    required this.id,
    required this.name,
  });
  

   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }
  
  @override

  List<Object?> get props => [id,name];
}
