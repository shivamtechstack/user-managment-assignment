import 'package:equatable/equatable.dart';

import '../../../data/models/post_model.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserPosts extends PostEvent {
  final int userId;

  FetchUserPosts(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddLocalPost extends PostEvent {
  final Post post;

  AddLocalPost(this.post);

  @override
  List<Object?> get props => [post];
}

