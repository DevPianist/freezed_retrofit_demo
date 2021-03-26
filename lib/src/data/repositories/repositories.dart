import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'user/user_repository.dart';

part 'repositories.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class Repositories {
  factory Repositories(Dio dio, {String baseUrl}) = _Repositories;
}

extension GettersExt on Repositories {
  UserRepository get user {
    final repo = this as _Repositories;
    return UserRepository(repo._dio, baseUrl: repo.baseUrl!);
  }
}
