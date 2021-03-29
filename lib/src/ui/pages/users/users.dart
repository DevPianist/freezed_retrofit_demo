import 'package:flutter/material.dart';

import '../../../data/models/request/user/user_request.dart';
import '../../dialogs/loading_dialog.dart';
import '../user/user.dart';
import 'local_dialogs/user_register_dialog.dart';
import 'user_register_bloc.dart';
import 'users_bloc.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  final _usersBloc = UsersBloc();
  final _registerBloc = UserRegisterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: FutureBuilder<void>(
        future: _usersBloc.getUsers(),
        builder: (context, _) {
          return StreamBuilder<UsersState>(
            initialData: _usersBloc.initialState,
            stream: _usersBloc.stream,
            builder: (context, snapshot) {
              final state = snapshot.data;
              switch (state) {
                case UsersState.empty:
                  return const Center(child: Text('No data'));
                case UsersState.success:
                  return ListView.builder(
                    itemCount: _usersBloc.users.length,
                    itemBuilder: (context, index) {
                      final user = _usersBloc.users[index];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserRegisterDialog.show(
            context,
            onSubmitted: (request) => _createUser(context, request),
            invalid: () {
              print('INVALID REQUEST');
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createUser(BuildContext context, UserRequest request) {
    final future = _registerBloc.createUser(request);
    LoadingDialog.show(
      context,
      future: () => future,
      onSuccess: () {
        print('onSuccess');
      },
      onError: (e) {
        print(e);
      },
    );
  }
}
