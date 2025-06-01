import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserTodos extends TodoEvent {
  final int userId;

  FetchUserTodos(this.userId);

  @override
  List<Object?> get props => [userId];
}
