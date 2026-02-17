import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_constants.dart';
import 'package:movies/core/utils/values_manager.dart';
import 'package:movies/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:movies/features/movie/domain/entity/movie_details.dart';
import 'package:movies/features/movie/presentation/screen/movie_details_screen.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteItem extends StatelessWidget {
  final MovieDetails movie;

  FavoriteItem({super.key,required this.movie});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding:  const EdgeInsets.all(AppSize.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                right: AppSize.s8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsScreen(
                              id: movie.id,
                            )));
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s8)),
                child: CachedNetworkImage(
                  height: 140,
                  width: 150,
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
          ),
          SizedBox(width: AppSize.s20,),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: size.width /3,
                  child: Text(
                    movie.title,
                    style: const TextStyle(

                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
              const SizedBox(height: AppSize.s8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.s2,
                      horizontal: AppSize.s8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius:
                      BorderRadius.circular(
                          AppSize.s4),
                    ),
                    child: Text(
                      movie.releaseDate.split(
                          '-')[AppSize.s0.toInt()],
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: AppSize.s16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.s16),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: AppSize.s20,
                  ),
                  const SizedBox(width: AppSize.s4),
                  Text(
                    ("${movie.voteAverage.round()}/10"),
                    style: const TextStyle(
                      fontSize: AppSize.s16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: AppSize.s1_2,
                    ),
                  ),
                  const SizedBox(width: AppSize.s20),
                  IconButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Action"),
                              content: const Text("Are you sure you want to delete?"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<FavoritesCubit>().toggleFavorite(movie);
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete,color: AppColors.red,)
                  )
                ],
              ),
              const SizedBox(height: AppSize.s8),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.s2,
                  horizontal: AppSize.s8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.softGrey,
                  borderRadius:
                  BorderRadius.circular(AppSize.s4),
                ),
                child: Text(
                  "${movie.voteCount} Votes",
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: AppSize.s1_2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

