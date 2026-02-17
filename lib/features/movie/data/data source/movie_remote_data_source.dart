import 'package:movies/features/movie/data/models/movie_details_model.dart';
import 'package:movies/features/movie/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrend();
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getTopRated();
  Future<MovieDetailsModel> getMovieDetails(int movieId);
  Future<List<MovieModel>> getSearchMovie(String title);
}