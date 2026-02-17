import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/error/execption.dart';
import 'package:movies/features/auth/domain/repo/auth_repo.dart';

@injectable
class LoginUseCase{
  AuthRepository authRepository;
  LoginUseCase({required this.authRepository});
  Future<Either<ServerException, Unit>> call(String email,String password)async{
    try{
      var result= await authRepository.login(email, password);
      return result ;
    }catch(e){
      return Left(ServerException(e.toString()));
    }
  }
}
