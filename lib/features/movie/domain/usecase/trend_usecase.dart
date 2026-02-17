import 'package:injectable/injectable.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';
import 'package:movies/features/movie/domain/repository/movie_repository.dart';

@injectable
class GetTrendUseCase{
  MovieRepository movieRepository;
  GetTrendUseCase({required this.movieRepository});
  Future<List<MovieDetails>> call()=> movieRepository.getTrend();
}