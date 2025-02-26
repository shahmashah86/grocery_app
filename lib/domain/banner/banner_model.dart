// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final int id;
  final String banner;
  const BannerModel({
    required this.id,
    required this.banner,
  });
  
  
 
  @override

  List<Object?> get props => [id,banner];


}
