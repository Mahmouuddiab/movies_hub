import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/layout/cubit/states.dart';
import 'package:movies/features/favorite/presentation/screen/favorite_screen.dart';
import 'package:movies/features/movie/presentation/screen/movies_screen.dart';
import 'package:movies/features/movie/presentation/screen/search_screen.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(LayoutInitialState());
  int currentIndex = 0;
  List<Widget> tabs = [MoviesScreen(),MovieSearchScreen(),FavoriteScreen()];
  void changeBottomNavIndex(int selectedIndex){
    currentIndex = selectedIndex;
    emit(ChangeBottomNavIndex());
  }
}
