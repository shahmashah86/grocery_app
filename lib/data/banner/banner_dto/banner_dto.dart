// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery_app/domain/banner/banner_model.dart';


class BannerDto {
  int id;
  String bannerUrl;
  BannerDto({
    required this.id,
    required this.bannerUrl,
  });


  factory BannerDto.fromMap(Map<String, dynamic> map) {
    return BannerDto(
      id: map['id'],
      bannerUrl:map['bannerUrl'] 
    );
  }


    BannerModel toModel() {
    return BannerModel(
    id: id,
    banner: bannerUrl
 
      
      );
  }
  
  

}
