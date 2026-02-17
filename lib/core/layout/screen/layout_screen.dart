import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/layout/cubit/cubit.dart';
import 'package:movies/core/layout/cubit/states.dart';
import 'package:movies/core/utils/app_strings.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});
  LayoutCubit cubit =LayoutCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit,LayoutStates>(
      bloc: cubit,
      builder: (context, state) => Scaffold(
        body: cubit.tabs[cubit.currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15)
          ),
          child: BottomNavigationBar(
              onTap: (value) => cubit.changeBottomNavIndex(value),
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              iconSize: 30,
              elevation: 0,
              selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold
              ),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold
              ),
              items: [
                BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/icons/Home.png")),label: AppStrings.home),
                BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/icons/Search.png")),label: AppStrings.search),
                BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/icons/wishlistsele.png")),label: AppStrings.watchList)
              ]
          ),
        ),
      ),
    );
  }
}
