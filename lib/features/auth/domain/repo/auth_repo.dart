import 'package:dartz/dartz.dart';
import 'package:movies/core/error/execption.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository{

  Future<Either<ServerException,Unit>> register(
      String name,
      String email,
      String password,
      String rePassword,
      String phone
      );
  Future<Either<ServerException,Unit>> login(String email, String password);
  Future<UserEntity?> getUserByEmail(String email);

}
