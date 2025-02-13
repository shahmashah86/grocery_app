part of 'get_orderby_id_bloc.dart';

sealed class GetOrderbyIdEvent extends Equatable {
  const GetOrderbyIdEvent();

  @override
  List<Object> get props => [];
}
class GetOrderEvent extends GetOrderbyIdEvent{
 final int id;

  GetOrderEvent({required this.id});

}