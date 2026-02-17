import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_constants.dart';
import 'package:movies/core/utils/values_manager.dart';
import 'package:movies/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:movies/features/favorite/presentation/cubit/favorite_states.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';
import 'package:movies/features/movie/presentation/screen/movie_details_screen.dart';
import 'package:shimmer/shimmer.dart';

class TrendItem extends StatelessWidget {
  final MovieDetails movie;
  int index;
   TrendItem({super.key,required this.movie,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: AppSize.s40),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(id: movie.id),));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: AppConstants.imageUrl(
                    movie.posterPath!),
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
          ),
          BlocBuilder<FavoritesCubit,FavoritesState>(
            builder: (context, state) {
              final cubit = context.read<FavoritesCubit>();
              final isFavorite = cubit.isFavorite(movie);
              return Positioned(
                  right: 4,
                  child: IconButton(
                      onPressed: (){
                        cubit.toggleFavorite(movie);
                        ScaffoldMessenger.of(context).showSnackBar
                          (
                            SnackBar(
                              backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),
                            content: Text("added to favorite",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white
                        ),)
                            )
                        );
                      },
                      icon: Icon(
                          isFavorite
                              ?Icons.favorite
                              :Icons.favorite_border,
                          color: isFavorite
                              ?Colors.red
                              :Colors.white
                      )
                  )
              );
            },
          ),

          Positioned(
            bottom: -15,
            left: -5,
            child: Stack(
              children: [
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 98,
                    height: 1.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.blue.shade800,
                  ),
                ),
                Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 96,
                    height: 1.0,
                    color: AppColors.defaultColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
