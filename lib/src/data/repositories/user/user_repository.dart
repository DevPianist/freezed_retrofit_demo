import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';
import '../../models/request/user/user_request.dart';

part 'user_repository.g.dart';

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET('/users')
  Future<HttpResponse<List<User>>> getUsers();

  @GET('/users/{id}')
  Future<HttpResponse<User>> getUser(@Path('id') int id);

  @POST('/users')
  Future<HttpResponse<User>> createUser(@Body() UserRequest request);
}
