import 'package:dartz/dartz.dart';
import 'package:movies/features/auth/data/model/user_data_model.dart';

abstract class AuthRemoteDataSource{
  Future<Unit> register(
      String name,
      String email,
      String password,
      String rePassword,
      String phone
      );
  Future<Unit> login(String email, String password);
  Future<UserDataModel?> getUserByEmail(String email);
}
