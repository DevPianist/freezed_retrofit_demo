import 'dart:async';

import 'package:dio/dio.dart';

import '../../../data/models/models.dart';
import '../../../data/models/request/request.dart';
import '../../../data/repositories/repositories.dart';
import '../../../utils/custom_bloc.dart';

enum UserRegisterState {
  loading,
  error,
  success,
}

class UserRegisterBloc implements CustomBloc<UserRegisterState> {
  final _userRegisterStateController =
      StreamController<UserRegisterState>.broadcast();

  Future<void> createUser(UserRequest request) async {
    try {
      final userRepository = Repositories(Dio()).user;
      final httpResponse = await userRepository.createUser(request);
      if (httpResponse.response.statusCode == 201 &&
          httpResponse.data is User) {
        _userRegisterStateController.add(UserRegisterState.success);
      } else {
        throw Exception(httpResponse.response.data);
      }
    } catch (e) {
      _userRegisterStateController.add(UserRegisterState.error);
      return Future.error('Future Error $e');
    }
  }

  @override
  UserRegisterState get initialState => UserRegisterState.loading;

  @override
  Stream<UserRegisterState> get stream => _userRegisterStateController.stream;

  @override
  void dispose() {
    _userRegisterStateController.close();
  }
}
