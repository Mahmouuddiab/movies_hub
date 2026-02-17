import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/error/execption.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/utils/app_strings.dart';
import 'package:movies/features/movie/data/data%20source/movie_local_data_source.dart';
import 'package:movies/features/movie/data/data%20source/movie_remote_data_source.dart';
import 'package:movies/features/movie/data/models/movie_model.dart';
import 'package:movies/features/movie/domain/entity/movie.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';
import 'package:movies/features/movie/domain/repository/movie_repository.dart';
import 'package:movies/features/movie/domain/usecase/wishlist_usecase.dart';

@Injectable(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  MovieRemoteDataSource movieRemoteDataSource;
  MovieLocalDataSource movieLocalDataSource;
  MovieRepositoryImpl({required this.movieRemoteDataSource,required this.movieLocalDataSource});
  @override
  Future<List<Movie>> getNowPlaying() async {
    final movie = await movieRemoteDataSource.getNowPlaying();
    return movie
        .map(
          (e) => Movie(
            id: e.id,
            title: e.title,
            originalLanguage: e.originalLanguage,
            voteCount: e.voteCount,
            genreIds: e.genreIds,
            overview: e.overview,
            voteAverage: e.voteAverage,
            releaseDate: e.releaseDate,
            posterPath: e.posterPath,
            backdropPath: e.backdropPath,
          ),
        )
        .toList();
  }

  @override
  Future<List<Movie>> getPopular() async {
    final movie = await movieRemoteDataSource.getPopular();
    return movie
        .map(
          (e) => Movie(
            id: e.id,
            title: e.title,
            originalLanguage: e.originalLanguage,
            voteCount: e.voteCount,
            genreIds: e.genreIds,
            overview: e.overview,
            voteAverage: e.voteAverage,
            releaseDate: e.releaseDate,
            posterPath: e.posterPath,
            backdropPath: e.backdropPath,
          ),
        )
        .toList();
  }

  @override
  Future<List<Movie>> getTopRated() async {
    final movie = await movieRemoteDataSource.getTopRated();
    return movie
        .map(
          (e) => Movie(
            id: e.id,
            title: e.title,
            originalLanguage: e.originalLanguage,
            voteCount: e.voteCount,
            genreIds: e.genreIds,
            overview: e.overview,
            voteAverage: e.voteAverage,
            releaseDate: e.releaseDate,
            posterPath: e.posterPath,
            backdropPath: e.backdropPath,
          ),
        )
        .toList();
  }

  @override
  Future<List<MovieDetails>> getTrend() async {
    final movie = await movieRemoteDataSource.getTrend();
    return movie
        .map(
          (e) => MovieDetails(
            id: e.id,
            title: e.title,
            voteCount: e.voteCount,
            voteAverage: e.voteAverage,
            releaseDate: e.releaseDate,
            backdropPath: e.backdropPath!,
            posterPath: e.posterPath!,
            overView: e.overview,
            runtime: 0,
            status: '',
            genres: [],
          ),
        )
        .toList();
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final movieDetails = await movieRemoteDataSource.getMovieDetails(movieId);
    return movieDetails;
  }

  @override
  Future<List<Movie>> getSearchMovie(String title) async {
    final movie = await movieRemoteDataSource.getSearchMovie(title);
    return movie
        .map(
          (e) => Movie(
            id: e.id,
            title: title,
            originalLanguage: e.originalLanguage,
            voteCount: e.voteCount,
            genreIds: e.genreIds,
            overview: e.overview,
            voteAverage: e.voteAverage,
            releaseDate: e.releaseDate,
            posterPath: e.posterPath
          ),
        )
        .toList();
  }

  @override
  Future<Either<Failure, void>> addToWishlist(AddToWishlistParameters parameter) async {
    try {
      final currentWishlist = await movieLocalDataSource.getWishLocalData();

      currentWishlist.add(parameter.movie);

      await movieLocalDataSource.cachedWishLocalData(movieModel: currentWishlist);

      return const Right(null);
    } on LocalExceptions catch (e) {
      if (e.message == AppStrings.noData) {
        await movieLocalDataSource.cachedWishLocalData(
            movieModel: [parameter.movie]
        );
        return const Right(null);
      }
      return Left(e.toString() as Failure);
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getWishListMovie()async{
    final result = await movieLocalDataSource.getWishLocalData();
    try {
      return Right(result);
    }
    on ServerException catch (failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(RemoveFromWishlistParameters parameter) async {
    try {
      final currentWishlist = await movieLocalDataSource.getWishLocalData();

      final updatedWishlist = currentWishlist
          .where((movie) => movie.id != parameter.movieId)
          .toList();

      await movieLocalDataSource.cachedWishLocalData(movieModel: updatedWishlist);

      return const Right(null);
    } on LocalExceptions catch (e) {
      return Left(e.message as Failure);
    }
  }
}
