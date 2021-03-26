import 'dart:async';

import 'package:dio/dio.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';

enum UsersState {
  loading,
  error,
  success,
  empty,
}

class UsersBloc {
  List<User>? _users;
  List<User> get users => _users ?? [];
  final initialState = UsersState.loading;
  final _usersStateController = StreamController<UsersState>.broadcast();
  Stream<UsersState> get usersState => _usersStateController.stream;
  Future<void> getUsers() async {
    try {
      // print(users.toString());
      // _usersStateController.add(UsersState.loading);
      final userRepository = Repositories(Dio()).user;
      final response = await userRepository.getUsers();
      if (response is List<User>) {
        _users = response;
        if (response.isNotEmpty) {
          _usersStateController.add(UsersState.success);
        } else {
          _usersStateController.add(UsersState.empty);
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      _usersStateController.add(UsersState.error);
    }
  }

  void dispose() {
    _usersStateController.close();
  }
}
