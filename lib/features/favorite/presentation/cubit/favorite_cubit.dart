import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/favorite/presentation/cubit/favorite_states.dart';
import 'package:movies/features/movie/domain/entity/movie.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  void toggleFavorite(MovieDetails movie) {
    // Get the current list of favorites.
    final currentFavorites =
    state is FavoritesLoaded ? (state as FavoritesLoaded).favoriteMovies : [];

    // Create a new list to avoid modifying the current state directly.
    final newFavorites = List<MovieDetails>.from(currentFavorites);

    // Check if the movie is already in the list.
    if (newFavorites.any((p) => p.id == movie.id)) {
      // Remove it if it exists.
      newFavorites.removeWhere((p) => p.id == movie.id);
    } else {
      // Add it if it doesn't.
      newFavorites.add(movie);
    }

    // Emit the new state with the updated list of favorites.
    emit(FavoritesLoaded(favoriteMovies: newFavorites));
  }

  bool isFavorite(MovieDetails movie) {
    if (state is FavoritesLoaded) {
      return (state as FavoritesLoaded).favoriteMovies.any((p) => p.id == movie.id);
    }
    return false;
  }
}
