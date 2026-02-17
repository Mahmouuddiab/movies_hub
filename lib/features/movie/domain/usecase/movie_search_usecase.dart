import 'package:injectable/injectable.dart';
import 'package:movies/features/movie/domain/entity/movie.dart';
import 'package:movies/features/movie/domain/repository/movie_repository.dart';

@injectable
class MovieSearchUseCase {
  MovieRepository movieRepository;
  MovieSearchUseCase({required this.movieRepository});
  Future<List<Movie>> call(String title)=> movieRepository.getSearchMovie(title);
}