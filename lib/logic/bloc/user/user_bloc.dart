import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagement/logic/bloc/user/user_event.dart';
import 'package:usermanagement/logic/bloc/user/user_state.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc({required this.repository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await repository.getUsers(
          limit: event.limit, skip: event.skip);
      emit(UserLoaded(users: users, hasReachedMax: users.length < event.limit));
    } catch (e) {
      emit(UserError("Failed to fetch users"));
    }
  }

  Future<void> _onSearchUsers(SearchUsers event,
      Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await repository.searchUsers(event.query);
      emit(UserLoaded(users: users, hasReachedMax: true));
    } catch (e) {
      emit(UserError("Failed to search users"));
    }
  }

  Future<void> _onLoadMoreUsers(LoadMoreUsers event,
      Emitter<UserState> emit) async {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      try {
        final users = await repository.getUsers(
            limit: event.limit, skip: event.skip);
        final updatedUsers = List<User>.from(currentState.users)
          ..addAll(users);
        emit(
          currentState.copyWith(
            users: updatedUsers,
            hasReachedMax: users.isEmpty,
          ),
        );
      } catch (e) {
        emit(UserError("Failed to load more users"));
      }
    }
  }
}