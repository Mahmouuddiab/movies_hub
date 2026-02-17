import 'package:movies/features/movie/domain/entity/movie.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';

abstract class MovieStates {}

class MovieInitialState extends MovieStates {}

class MovieLoading extends MovieStates {}
class MovieLoaded extends MovieStates {
  List<MovieDetails> getTrends;
  List<Movie> nowPlaying;
  List<Movie> topRated;
  List<Movie> popular;
  MovieLoaded({
    required this.getTrends,
    required this.nowPlaying,
    required this.topRated,
    required this.popular,
  });
}
class MovieError extends MovieStates {
  String error;
  MovieError({required this.error});
}

class MovieDetailsLoading extends MovieStates{}
class MovieDetailsLoaded extends MovieStates{
  MovieDetails movieDetails;
  MovieDetailsLoaded({required this.movieDetails});
}
class MovieDetailsError extends MovieStates{}

class MovieSearchLoading extends MovieStates{}
class MovieSearchLoaded extends MovieStates{
  List<Movie> movieSearch;
  MovieSearchLoaded({required this.movieSearch});
}
class MovieSearchError extends MovieStates{
  String message;
  MovieSearchError({required this.message});
}


