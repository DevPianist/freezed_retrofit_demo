import 'package:flutter/material.dart';

import '../user/user.dart';
import 'users_bloc.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  final _bloc = UsersBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: FutureBuilder<void>(
        future: _bloc.getUsers(),
        builder: (context, _) {
          return StreamBuilder<UsersState>(
            initialData: _bloc.initialState,
            stream: _bloc.usersState,
            builder: (context, snapshot) {
              final state = snapshot.data;
              switch (state) {
                case UsersState.empty:
                  return const Center(child: Text('No data'));
                case UsersState.success:
                  return ListView.builder(
                    itemCount: _bloc.users.length,
                    itemBuilder: (context, index) {
                      final user = _bloc.users[index];
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        child: ListTile(
                          onTap: () {
                            UserPage.navigate(
                              context,
                              id: user.id,
                              name: user.name ?? 'No name',
                            );
                          },
                          title: Text(user.name ?? 'No name'),
                          subtitle: Text(user.email ?? 'No email'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14.0,
                          ),
                        ),
                      );
                    },
                  );
                case UsersState.error:
                  return const Center(child: Text('Error'));
                case UsersState.loading:
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
