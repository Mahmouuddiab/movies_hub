import 'package:injectable/injectable.dart';
import 'package:movies/features/movie/domain/entity/movie.dart';
import 'package:movies/features/movie/domain/repository/movie_repository.dart';

@injectable
class GetPopularUseCase{
  MovieRepository movieRepository;
  GetPopularUseCase({required this.movieRepository});
  Future<List<Movie>> call()=> movieRepository.getPopular();
}