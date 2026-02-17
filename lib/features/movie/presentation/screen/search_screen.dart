import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_strings.dart';
import 'package:movies/features/movie/presentation/cubit/movie_cubit.dart';
import 'package:movies/features/movie/presentation/cubit/movie_states.dart';
import 'package:movies/features/movie/presentation/widgets/search_widget.dart';
class MovieSearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  MovieSearchScreen({super.key});
  MovieCubit movieCubit = getIt<MovieCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: AppStrings.search,
                      suffixIcon: IconButton(
                        icon: ImageIcon(AssetImage("assets/icons/Search.png")),
                        onPressed: () {
                          movieCubit.getMovieSearch(controller.text);
                        },
                      ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.red)
                    ),
                    filled: false
                  ),
                ),
              ),
              Gap(10),
              Expanded(
                child: BlocBuilder<MovieCubit, MovieStates>(
                  bloc: movieCubit,
                  builder: (context, state) {
                    if (state is MovieSearchLoading) {
                      return Center(child: CircularProgressIndicator());

                    }

                    else if (state is MovieSearchLoaded) {
                      return ListView.builder(
                        itemCount: state.movieSearch.length,
                        itemBuilder: (context, index) {
                          final movie = state.movieSearch[index];
                          return MovieSearchWidget(movieSearch: movie) ;
                        },
                      );
                    }

                    else if (state is MovieSearchError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(child: Text("Search for a movie",style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
