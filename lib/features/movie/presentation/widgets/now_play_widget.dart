import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_constants.dart';
import 'package:movies/core/utils/values_manager.dart';
import 'package:movies/features/movie/presentation/cubit/movie_cubit.dart';
import 'package:movies/features/movie/presentation/cubit/movie_states.dart';
import 'package:movies/features/movie/presentation/screen/movie_details_screen.dart';
import 'package:shimmer/shimmer.dart';

class NowPlayWidget extends StatelessWidget {
  NowPlayWidget({super.key});
  MovieCubit movieCubit = getIt<MovieCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieStates>(
      bloc: movieCubit..getAllMovies(),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppSize.s10),
          child: Column(
            spacing: 20,
            children: [
              state is MovieLoaded
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2 / 3,
                        ),
                        itemCount: state.nowPlaying.length,
                        itemBuilder: (context, index) {
                          final nowPlayMovie = state.nowPlaying[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(id: nowPlayMovie.id),));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(15),
                              child: CachedNetworkImage(
                                height: 150,
                                width: 170,
                                fit: BoxFit.cover,
                                imageUrl: AppConstants.imageUrl(
                                    nowPlayMovie.posterPath!),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[850]!,
                                      highlightColor: Colors.grey[800]!,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                          BorderRadius.circular(
                                              AppSize.s8),
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        );
      },
    );
  }
}
