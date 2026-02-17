import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/error/execption.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';
import 'package:movies/features/auth/domain/repo/auth_repo.dart';
import '../data source/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl ({required this.authRemoteDataSource});
  @override
  Future<Either<ServerException, Unit>> login(String email, String password)async{
    await authRemoteDataSource.login(email, password);
    return Right(unit);
  }

  @override
  Future<Either<ServerException, Unit>> register(String name, String email, String password, String rePassword, String phone)async{
    await authRemoteDataSource.register(name, email, password, rePassword, phone);
    return Right(unit);
  }

  @override
  Future<UserEntity?> getUserByEmail(String email) {
    return authRemoteDataSource.getUserByEmail(email) ;
  }
  


}
