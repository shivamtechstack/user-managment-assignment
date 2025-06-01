import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/providers/user_api_provider.dart';
import '../../logic/bloc/post/post_bloc.dart';
import '../../logic/bloc/post/post_event.dart';
import '../../logic/bloc/todo/todo_block.dart';
import '../../logic/bloc/todo/todo_event.dart';
import '../screens/user_detail/user_detail_screen.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final apiProvider = context.read<UserApiProvider>();

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<PostBloc>(
                  create: (_) => PostBloc(apiProvider)..add(FetchUserPosts(user.id)),
                ),
                BlocProvider<TodoBloc>(
                  create: (_) => TodoBloc(apiProvider)..add(FetchUserTodos(user.id)),
                ),
              ],
              child: UserDetailScreen(user: user),
            ),
          ),
        );
      },
    );
  }
}

