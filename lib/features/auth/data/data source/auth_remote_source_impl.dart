import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/local/token_store.dart';
import 'package:movies/core/network/dio_helper.dart';
import 'package:movies/features/auth/data/model/UserModel.dart';
import 'package:movies/features/auth/data/model/user_data_model.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Unit> login(String email, String password) async {
    final response = await DioHelper.postData(
      url: "https://ecommerce.routemisr.com/api/v1/auth/signin",
      data: {"email": email, "password": password},
    );
    final userResponse = UserModel.fromJson(response.data);
    if (userResponse.token != null && userResponse.token!.isNotEmpty) {
      await TokenStorage.saveToken(userResponse.token!);
    }
    final token = response.data['token'];
     email = response.data['user']['email'];

    return unit;
  }

  @override
  Future<Unit> register(
    String name,
    String email,
    String password,
    String rePassword,
    String phone,
  ) async {
    final response = await DioHelper.postData(
      url: "https://ecommerce.routemisr.com/api/v1/auth/signup",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": phone,
      },
    );
    final userResponse = UserModel.fromJson(response.data);
    return unit;
  }

  @override
  Future<UserDataModel?> getUserByEmail(String email)async{
    final response = await DioHelper.getData(
      url: "https://ecommerce.routemisr.com/api/v1/users",
      queryParameters: {
        'email': email,
      },
    );

    final data = response.data['data'];

    if (data.isEmpty) return null;

    return UserDataModel.fromJson(data[0]);

  }




}
