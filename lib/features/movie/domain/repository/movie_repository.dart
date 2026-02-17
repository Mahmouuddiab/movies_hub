import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/features/movie/data/models/movie_model.dart';
import 'package:movies/features/movie/domain/entity/movie.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';
import 'package:movies/features/movie/domain/usecase/wishlist_usecase.dart';

abstract class MovieRepository {
  Future<List<MovieDetails>> getTrend();

  Future<List<Movie>> getNowPlaying();

  Future<List<Movie>> getPopular();

  Future<List<Movie>> getTopRated();

  Future<MovieDetails> getMovieDetails(int movieId);

  Future<List<Movie>> getSearchMovie(String title);

  Future<Either<Failure, List<MovieModel>>> getWishListMovie();

  Future<Either<Failure, void>> addToWishlist(AddToWishlistParameters parameter);

  Future<Either<Failure, void>> removeFromWishlist(RemoveFromWishlistParameters parameter);
}