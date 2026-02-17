import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';
import 'package:movies/features/auth/domain/repo/auth_repo.dart';

@injectable
class GetUserByEmailUseCase {
  final AuthRepository repo;

  GetUserByEmailUseCase(this.repo);

  Future<UserEntity?> call(String email) {
    return repo.getUserByEmail(email);
  }
}
