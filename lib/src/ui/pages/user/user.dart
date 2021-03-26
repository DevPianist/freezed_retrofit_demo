import 'package:flutter/material.dart';

import 'user_bloc.dart';

class UserPage extends StatelessWidget {
  UserPage({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  final int id;
  final String name;
  final _bloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: FutureBuilder<void>(
          future: _bloc.getUser(id),
          builder: (context, _) {
            return StreamBuilder<UserState>(
              stream: _bloc.userState,
              builder: (context, snapshot) {
                final state = snapshot.data;
                switch (state) {
                  case UserState.success:
                    final user = _bloc.user;
                    return ListView(
                      children: [
                        ListTile(
                          title: Text(user.email ?? 'No email'),
                          subtitle: const Text('Email'),
                        ),
                        ListTile(
                          title: Text(user.address?.city ?? 'No city'),
                          subtitle: const Text('City'),
                        ),
                        ListTile(
                          title: Text(user.company?.name ?? 'No company'),
                          subtitle: const Text('Company'),
                        ),
                        ListTile(
                          title: Text(user.phone ?? 'No phone'),
                          subtitle: const Text('Phone'),
                        ),
                        ListTile(
                          title: Text(user.website ?? 'No website'),
                          subtitle: const Text('Website'),
                        ),
                      ],
                    );
                  case UserState.error:
                    return const Center(child: Text('Error'));
                  case UserState.loading:
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
    );
  }

  static Future<void> navigate(
    BuildContext context, {
    required int id,
    required String name,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UserPage(id: id, name: name)),
    );
  }
}
