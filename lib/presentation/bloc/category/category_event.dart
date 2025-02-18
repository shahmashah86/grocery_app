// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryGet extends CategoryEvent {}

class CategoryCreate extends CategoryEvent {
  String categeoryName;
  CategoryCreate({
    required this.categeoryName,
  });
  @override
  List<Object> get props => [categeoryName];
}

class CategoryUpdate extends CategoryEvent {
  String categoryName;
  int id;
  CategoryUpdate({
    required this.id,
    required this.categoryName,
  });
  @override
  List<Object> get props => [categoryName, id];
}

class CategoryDelete extends CategoryEvent {
  int id;
  CategoryDelete({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}

class CategorylistbyId extends CategoryEvent {
  int id;
  CategorylistbyId({
    required this.id,
  });

 
}

