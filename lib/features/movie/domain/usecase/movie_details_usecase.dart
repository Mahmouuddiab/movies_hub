import 'package:injectable/injectable.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';
import 'package:movies/features/movie/domain/repository/movie_repository.dart';

@injectable
class MovieDetailsUseCase {
  MovieRepository movieRepository;
  MovieDetailsUseCase({required this.movieRepository});
  Future<MovieDetails> call(int movieId)=> movieRepository.getMovieDetails(movieId);
}