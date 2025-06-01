import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagement/data/providers/user_api_provider.dart';
import 'package:usermanagement/data/repositories/user_repository.dart';
import 'package:usermanagement/logic/bloc/user/user_event.dart';
import 'package:usermanagement/presentation/screens/user_list/user_list_screen.dart';
import 'data/repositories/post_repository.dart';
import 'data/repositories/todo_repository.dart';
import 'logic/bloc/user/user_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<UserRepository>(
                  create: (_) => UserRepository(apiProvider: UserApiProvider())),
              RepositoryProvider<PostRepository>(create: (_) => PostRepository()),
              RepositoryProvider<TodoRepository>(create: (_) => TodoRepository()),
              RepositoryProvider<UserApiProvider>(create: (_) => UserApiProvider()),
            ],
            child: BlocProvider<UserBloc>(
              create: (context) => UserBloc(repository: context.read<UserRepository>())..add(FetchUsers()),
              child: UserListScreen(onToggleTheme: _toggleTheme),
            ),
          ),
        );
      },
    );
  }

  void _toggleTheme() {
    _themeModeNotifier.value =
    _themeModeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
