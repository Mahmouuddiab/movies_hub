// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data%20source/auth_remote_data_source.dart'
    as _i214;
import '../../features/auth/data/data%20source/auth_remote_source_impl.dart'
    as _i335;
import '../../features/auth/data/repo%20impl/repo_impl.dart' as _i240;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/usecase/get_me.dart' as _i3;
import '../../features/auth/domain/usecase/login.dart' as _i754;
import '../../features/auth/domain/usecase/register.dart' as _i1045;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/movie/data/data%20source/movie_local_data_source.dart'
    as _i849;
import '../../features/movie/data/data%20source/movie_remote_data_source.dart'
    as _i1026;
import '../../features/movie/data/data%20source/movie_remote_data_source_impl.dart'
    as _i454;
import '../../features/movie/data/repository%20impl/movie_repository_impl.dart'
    as _i613;
import '../../features/movie/domain/repository/movie_repository.dart' as _i715;
import '../../features/movie/domain/usecase/movie_details_usecase.dart'
    as _i269;
import '../../features/movie/domain/usecase/movie_search_usecase.dart' as _i827;
import '../../features/movie/domain/usecase/now_playing_usecase.dart' as _i188;
import '../../features/movie/domain/usecase/popular_usecase.dart' as _i729;
import '../../features/movie/domain/usecase/top_rated_usecase.dart' as _i848;
import '../../features/movie/domain/usecase/trend_usecase.dart' as _i331;
import '../../features/movie/domain/usecase/wishlist_usecase.dart' as _i535;
import '../../features/movie/presentation/cubit/movie_cubit.dart' as _i580;
import '../network/dio_helper.dart' as _i172;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i172.DioHelper>(() => _i172.DioHelper());
    gh.factory<_i849.MovieLocalDataSource>(
      () => _i849.MovieLocalDataSourceImpl(),
    );
    gh.factory<_i214.AuthRemoteDataSource>(
      () => _i335.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i1026.MovieRemoteDataSource>(
      () => _i454.MovieRemoteDataSourceImpl(),
    );
    gh.factory<_i170.AuthRepository>(
      () => _i240.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i214.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i754.LoginUseCase>(
      () => _i754.LoginUseCase(authRepository: gh<_i170.AuthRepository>()),
    );
    gh.factory<_i1045.RegisterUseCase>(
      () => _i1045.RegisterUseCase(authRepository: gh<_i170.AuthRepository>()),
    );
    gh.factory<_i715.MovieRepository>(
      () => _i613.MovieRepositoryImpl(
        movieRemoteDataSource: gh<_i1026.MovieRemoteDataSource>(),
        movieLocalDataSource: gh<_i849.MovieLocalDataSource>(),
      ),
    );
    gh.factory<_i269.MovieDetailsUseCase>(
      () => _i269.MovieDetailsUseCase(
        movieRepository: gh<_i715.MovieRepository>(),
      ),
    );
    gh.factory<_i827.MovieSearchUseCase>(
      () => _i827.MovieSearchUseCase(
        movieRepository: gh<_i715.MovieRepository>(),
      ),
    );
    gh.factory<_i188.GetNowPlayingUseCase>(
      () => _i188.GetNowPlayingUseCase(
        movieRepository: gh<_i715.MovieRepository>(),
      ),
    );
    gh.factory<_i729.GetPopularUseCase>(
      () =>
          _i729.GetPopularUseCase(movieRepository: gh<_i715.MovieRepository>()),
    );
    gh.factory<_i848.GetTopRatedUseCase>(
      () => _i848.GetTopRatedUseCase(
        movieRepository: gh<_i715.MovieRepository>(),
      ),
    );
    gh.factory<_i331.GetTrendUseCase>(
      () => _i331.GetTrendUseCase(movieRepository: gh<_i715.MovieRepository>()),
    );
    gh.factory<_i3.GetUserByEmailUseCase>(
      () => _i3.GetUserByEmailUseCase(gh<_i170.AuthRepository>()),
    );
    gh.factory<_i535.GetWishlistUseCase>(
      () => _i535.GetWishlistUseCase(gh<_i715.MovieRepository>()),
    );
    gh.factory<_i535.AddToWishlistUseCase>(
      () => _i535.AddToWishlistUseCase(gh<_i715.MovieRepository>()),
    );
    gh.factory<_i535.RemoveFromWishlistUseCase>(
      () => _i535.RemoveFromWishlistUseCase(gh<_i715.MovieRepository>()),
    );
    gh.factory<_i580.MovieCubit>(
      () => _i580.MovieCubit(
        gh<_i331.GetTrendUseCase>(),
        gh<_i188.GetNowPlayingUseCase>(),
        gh<_i848.GetTopRatedUseCase>(),
        gh<_i729.GetPopularUseCase>(),
        gh<_i269.MovieDetailsUseCase>(),
        gh<_i827.MovieSearchUseCase>(),
      ),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        gh<_i754.LoginUseCase>(),
        gh<_i1045.RegisterUseCase>(),
        gh<_i3.GetUserByEmailUseCase>(),
      ),
    );
    return this;
  }
}
