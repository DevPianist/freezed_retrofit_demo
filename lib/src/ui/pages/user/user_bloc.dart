import 'dart:async';

import 'package:dio/dio.dart';
import '../../../utils/custom_bloc.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';

enum UserState {
  loading,
  error,
  success,
}

class UserBloc implements CustomBloc<UserState> {
  User? _user;
  User get user => _user ?? User.fromJson({});
  final _userStateController = StreamController<UserState>.broadcast();

  Future<void> getUser(int id) async {
    try {
      final userRepository = Repositories(Dio()).user;
      final httpResponse = await userRepository.getUser(id);
      if (httpResponse.response.statusCode == 200 &&
          httpResponse.data is User) {
        _user = httpResponse.data;
        _userStateController.add(UserState.success);
      } else {
        throw Exception(httpResponse.response.data);
      }
    } catch (e) {
      print(e);
      _userStateController.add(UserState.error);
      return Future.error('Future Error $e');
    }
  }

  @override
  void dispose() {
    _userStateController.close();
  }

  @override
  UserState get initialState => UserState.loading;

  @override
  Stream<UserState> get stream => _userStateController.stream;
}
