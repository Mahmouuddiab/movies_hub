import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:movies/features/favorite/presentation/cubit/favorite_states.dart';
import 'package:movies/features/favorite/presentation/favorite_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<FavoritesCubit,FavoritesState>(
      builder: (context, state) {
        if(state is FavoritesInitial){
          return Center(child: Text("favorites is empty"),) ;
        }
        if(state is FavoritesLoaded){
          return Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                  )
              ),
              title: Text("Wishlist",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
              ),),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: state.favoriteMovies.length,
              itemBuilder: (context, index) {
                var favorite = state.favoriteMovies[index];
                return FavoriteItem(movie: favorite) ;
              },
            ),
          ) ;
        }
        return SizedBox() ;
      },
    ) ;
  }
}
