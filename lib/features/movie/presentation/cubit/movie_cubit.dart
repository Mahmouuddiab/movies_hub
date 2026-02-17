import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/movie/data/models/movie_model.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';
import 'package:movies/features/movie/domain/usecase/movie_details_usecase.dart';
import 'package:movies/features/movie/domain/usecase/movie_search_usecase.dart';
import 'package:movies/features/movie/domain/usecase/now_playing_usecase.dart';
import 'package:movies/features/movie/domain/usecase/popular_usecase.dart';
import 'package:movies/features/movie/domain/usecase/top_rated_usecase.dart';
import 'package:movies/features/movie/domain/usecase/trend_usecase.dart';
import 'package:movies/features/movie/presentation/cubit/movie_states.dart';

@injectable
class MovieCubit extends Cubit<MovieStates> {
  GetTrendUseCase getTrendUseCase;
  GetNowPlayingUseCase getNowPlayingUseCase;
  GetTopRatedUseCase getTopRatedUseCase;
  GetPopularUseCase getPopularUseCase;
  MovieDetailsUseCase movieDetailsUseCase;
  MovieSearchUseCase movieSearchUseCase;
  MovieCubit(
    this.getTrendUseCase,
    this.getNowPlayingUseCase,
    this.getTopRatedUseCase,
    this.getPopularUseCase,
    this.movieDetailsUseCase,
    this.movieSearchUseCase
  ) : super(MovieInitialState());

  Future<void> getAllMovies() async {
    emit(MovieLoading());
    try {
      final trendMovies = await getTrendUseCase();
      final nowPlayingMovies = await getNowPlayingUseCase();
      final topRatedMovies = await getTopRatedUseCase();
      final popularMovies = await getPopularUseCase();
      emit(
        MovieLoaded(
          getTrends: trendMovies,
          nowPlaying: nowPlayingMovies,
          topRated: topRatedMovies,
          popular: popularMovies,
        ),
      );
    } catch (e) {
      emit(MovieError(error: e.toString()));
    }
  }

  MovieModel? movieDetails;

  Future<void> getMovieDetails(int movieId)async{
    emit(MovieDetailsLoading());
    try{
      final movieDetails = await movieDetailsUseCase(movieId);
      emit(MovieDetailsLoaded(movieDetails: movieDetails));
    }
    catch(e){
      emit(MovieDetailsError());
    }
  }
  final TextEditingController searchController = TextEditingController();

  Future<void> getMovieSearch(String title)async{
    emit(MovieDetailsLoading());
    try{
      final movieSearch = await movieSearchUseCase(title);
      emit(MovieSearchLoaded(movieSearch: movieSearch));
    }
    catch(e){
      emit(MovieSearchError(message: e.toString()));
    }
  }

}
