// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryGet extends CategoryEvent {}

class CategoryCreate extends CategoryEvent {
  final String categeoryName;
  const CategoryCreate({
    required this.categeoryName,
  });
  @override
  List<Object> get props => [categeoryName];
}

class CategoryUpdate extends CategoryEvent {
  final String categoryName;
  final int id;
  const CategoryUpdate({
    required this.id,
    required this.categoryName,
  });
  @override
  List<Object> get props => [categoryName, id];
}

class CategoryDelete extends CategoryEvent {
 final int id;
  const CategoryDelete({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}

class CategorylistbyId extends CategoryEvent {
 final int id;
  const CategorylistbyId({
    required this.id,
  });

 
}

