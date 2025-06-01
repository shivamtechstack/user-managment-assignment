import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/providers/user_api_provider.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UserApiProvider api;

  PostBloc(this.api) : super(PostInitial()) {
    on<FetchUserPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await api.fetchPosts(event.userId);
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError('Failed to fetch posts'));
      }
    });

    on<AddLocalPost>((event, emit) {
      if (state is PostLoaded) {
        final currentPosts = (state as PostLoaded).posts;
        final updatedPosts = [event.post, ...currentPosts];
        emit(PostLoaded(updatedPosts));
      }
    });
    
  }
}
