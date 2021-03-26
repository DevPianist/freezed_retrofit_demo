import 'dart:async';

import 'package:dio/dio.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';

enum UserState {
  loading,
  error,
  success,
}

class UserBloc {
  User? _user;
  User get user => _user ?? User.fromJson({});
  final initialState = UserState.loading;
  final _userStateController = StreamController<UserState>.broadcast();
  Stream<UserState> get userState => _userStateController.stream;
  Future<void> getUser(int id) async {
    try {
      final userRepository = Repositories(Dio()).user;
      final response = await userRepository.getUser(id);
      if (response is User) {
        _user = response;
        _userStateController.add(UserState.success);
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      _userStateController.add(UserState.error);
    }
  }

  void dispose() {
    _userStateController.close();
  }
}
