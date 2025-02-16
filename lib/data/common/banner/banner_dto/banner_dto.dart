// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery_app/domain/common/model/banner/banner_model/banner_model.dart';

class BannerDto {
  int id;
  String bannerUrl;
  BannerDto({
    required this.id,
    required this.bannerUrl,
  });

    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bannerIrl': bannerUrl,
    };
  }

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
