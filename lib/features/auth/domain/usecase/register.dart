import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/error/execption.dart';
import 'package:movies/features/auth/domain/repo/auth_repo.dart';


@injectable
class RegisterUseCase {
  AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});
  Future<Either<ServerException, Unit>> call(
      String name,
      String email,
      String password,
      String rePassword,
      String phone,
      ) async {
    try {
      var result = await authRepository.register(
        name,
        email,
        password,
        rePassword,
        phone,
      );
      return result;
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}
