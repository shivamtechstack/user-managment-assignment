import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/user/user_bloc.dart';
import '../../../logic/bloc/user/user_event.dart';
import '../../../logic/bloc/user/user_state.dart';
import '../../widgets/user_tile.dart';

class UserListScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const UserListScreen({super.key, required this.onToggleTheme});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  int _limit = 10;

  int _skip = 0;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && !_isSearching) {
      _skip += _limit;
      context.read<UserBloc>().add(LoadMoreUsers(limit: _limit, skip: _skip));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      setState(() => _isSearching = true);
      context.read<UserBloc>().add(SearchUsers(query));
    } else {
      setState(() {
        _isSearching = false;
        _skip = 0;
      });
      context.read<UserBloc>().add(FetchUsers(limit: _limit, skip: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[400],
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  if (state.users.isEmpty) {
                    return const Center(child: Text('No users found.'));
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax ? state.users.length : state.users.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= state.users.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final user = state.users[index];
                      return UserTile(user: user);
                    },
                  );
                } else if (state is UserError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}