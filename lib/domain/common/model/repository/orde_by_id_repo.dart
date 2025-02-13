import 'package:grocery_app/domain/common/model/order_byid_model/order_byid_model.dart';

abstract class OrdeByIdRepo {
  Future<OrderByidModel> getAnOrderbyId(int id);
}