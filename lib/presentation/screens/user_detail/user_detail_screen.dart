import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../logic/bloc/post/post_bloc.dart';
import '../../../logic/bloc/post/post_event.dart';
import '../../../logic/bloc/post/post_state.dart';
import '../../../logic/bloc/todo/todo_block.dart';
import '../../../logic/bloc/todo/todo_event.dart';
import '../../../logic/bloc/todo/todo_state.dart';
import '../create_post/create_post_screen.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchUserPosts(widget.user.id));
    context.read<TodoBloc>().add(FetchUserTodos(widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.firstName),
      backgroundColor: Colors.green[400],),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(),
            const Divider(),
            _buildPostsSection(),
            const Divider(),
            _buildTodosSection(),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreatePostScreen(userId: widget.user.id),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUserInfo() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.user.image),
        radius: 30,
      ),
      title: Text('${widget.user.firstName} ${widget.user.lastName}'),
      subtitle: Text(widget.user.email),
    );
  }

  Widget _buildPostsSection() {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Error: ${state.message}'),
          );
        } else if (state is PostLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Posts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...state.posts.map((post) => ListTile(
                title: Text(post.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                    Wrap(
                      spacing: 6,
                      children: post.tags.map((tag) => Chip(label: Text(tag))).toList(),
                    ),
                    Row(
                      children: [
                        Icon(Icons.visibility, size: 16),
                        const SizedBox(width: 4),
                        Text('${post.views}'),
                        const SizedBox(width: 12),
                        Icon(Icons.thumb_up, size: 16),
                        const SizedBox(width: 4),
                        Text('${post.likes}'),
                        const SizedBox(width: 12),
                        Icon(Icons.thumb_down, size: 16),
                        const SizedBox(width: 4),
                        Text('${post.dislikes}'),
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
              ))
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildTodosSection() {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Error: ${state.message}'),
          );
        } else if (state is TodoLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Todos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...state.todos.map((todo) => CheckboxListTile(
                value: todo.completed,
                onChanged: null,
                title: Text(todo.todo),
              ))
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
