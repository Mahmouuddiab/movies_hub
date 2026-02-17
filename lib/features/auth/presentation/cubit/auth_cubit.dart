import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/local/secure_storage.dart';
import 'package:movies/features/auth/domain/usecase/get_me.dart';
import 'package:movies/features/auth/domain/usecase/login.dart';
import 'package:movies/features/auth/domain/usecase/register.dart';
import 'package:movies/features/auth/presentation/cubit/auth_states.dart';

@injectable
class AuthCubit extends Cubit<AuthStates>{
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetUserByEmailUseCase getUserByEmail;
  AuthCubit(this.loginUseCase,this.registerUseCase,this.getUserByEmail):super(AuthInitialState());

  Future<void> login(String email,String password)async{
    emit(LoginLoadingState());
    var response= await loginUseCase.call(email, password);
    return response.fold(
          (l) {
        emit(LoginErrorState(l.message));
      },
          (r) {
        emit(LoginSuccessState());
      },
    ) ;
  }

  Future<void> register(String name,String email,String password,String rePassword,String phone)async{
    emit(RegisterLoadingState());
    var response =await registerUseCase.call(name, email, password, rePassword, phone);
    return response.fold(
          (l) {
        emit(RegisterErrorState(l.message));
      },
          (r) {
        emit(RegisterSuccessState());
      },
    ) ;
  }

  void loadProfile() async {

    emit(ProfileLoading());

    try {

      final email = await SecureStorage.getEmail();

      if (email == null) {
        emit(ProfileUnauthenticated());
        return;
      }

      final user = await getUserByEmail(email);

      if (user == null) {
        emit(ProfileEmpty());
      } else {
        emit(ProfileLoaded(user));
      }

    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {

    await SecureStorage.clear();

    emit(ProfileLoggedOut());
  }
}
