part of 'get_orderby_id_bloc.dart';

sealed class GetOrderbyIdState extends Equatable {
  const GetOrderbyIdState();
  
  @override
  List<Object> get props => [];
}

final class GetOrderbyIdInitial extends GetOrderbyIdState {}
final class GetAnOrderbyIdLoaded extends GetOrderbyIdState{
 final OrderByidModel orderById;

 const GetAnOrderbyIdLoaded({required this.orderById});
}
