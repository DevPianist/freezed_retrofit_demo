import 'dart:async';

import 'package:dio/dio.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';
import '../../../utils/custom_bloc.dart';

enum UsersState {
  loading,
  error,
  success,
  empty,
}

class UsersBloc implements CustomBloc<UsersState> {
  List<User>? _users;
  List<User> get users => _users ?? [];
  final _usersStateController = StreamController<UsersState>.broadcast();

  Future<void> getUsers() async {
    try {
      final userRepository = Repositories(Dio()).user;
      final httpResponse = await userRepository.getUsers();
      if (httpResponse.response.statusCode == 200 &&
          httpResponse.data is List<User>) {
        _users = httpResponse.data;
        if (_users!.isNotEmpty) {
          _usersStateController.add(UsersState.success);
        } else {
          _usersStateController.add(UsersState.empty);
        }
      } else {
        throw Exception(httpResponse.response.data);
      }
    } catch (e) {
      print(e);
      _usersStateController.add(UsersState.error);
      return Future.error('Future Error $e');
    }
  }

  @override
  UsersState get initialState => UsersState.loading;

  @override
  Stream<UsersState> get stream => _usersStateController.stream;

  @override
  void dispose() {
    _usersStateController.close();
  }
}
