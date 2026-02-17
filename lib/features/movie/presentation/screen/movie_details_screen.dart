import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_constants.dart';
import 'package:movies/features/movie/presentation/cubit/movie_cubit.dart';
import 'package:movies/features/movie/presentation/cubit/movie_states.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;

  MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieCubit movieCubit;

  @override
  void initState() {
    super.initState();
    movieCubit = getIt<MovieCubit>();

    movieCubit.getMovieDetails(widget.id); // ✅ Call once here
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieStates>(
      bloc: movieCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "Movie Details",
              style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            ),
            centerTitle: true,
          ),
          body:
          state is MovieDetailsLoaded
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: Image.network(AppConstants.imageUrl(state.movieDetails.posterPath),height: 400)),
                Text(state.movieDetails.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(state.movieDetails.overView),
                Row(
                  children: [
                    Text("Genre:"),
                    SizedBox(width: 10,),
                    Row(
                      spacing: 10,
                      children: List.generate(
                        state.movieDetails.genres.length,
                            (index) {
                          final genre = state.movieDetails.genres[index];
                          return Text(genre.name) ;
                        },
                      ),
                    )
                  ],
                ),
                Text("Status:  ${state.movieDetails.status}"),
                Text("Release Date: ${state.movieDetails.releaseDate}"),
                Text("Vote Average: ${state.movieDetails.voteAverage}"),
              ],
            ),
          )
          : SizedBox.shrink(),
        );
      },
    );
  }
}
