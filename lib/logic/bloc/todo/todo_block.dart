import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/providers/user_api_provider.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserApiProvider api;

  TodoBloc(this.api) : super(TodoInitial()) {
    on<FetchUserTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await api.fetchTodos(event.userId);
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Failed to fetch todos'));
      }
    });
  }
}
