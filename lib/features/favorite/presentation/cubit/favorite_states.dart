import 'package:movies/features/movie/domain/entity/movie_details.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<MovieDetails> favoriteMovies;

  FavoritesLoaded({required this.favoriteMovies});
}
