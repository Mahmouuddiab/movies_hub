import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/themes/theme_cubit.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_strings.dart';
import 'package:movies/core/utils/values_manager.dart';
import 'package:movies/features/movie/presentation/cubit/movie_cubit.dart';
import 'package:movies/features/movie/presentation/cubit/movie_states.dart';
import 'package:movies/features/movie/presentation/widgets/now_play_widget.dart';
import 'package:movies/features/movie/presentation/widgets/popular_widget.dart';
import 'package:movies/features/movie/presentation/widgets/top_rated_widget.dart';
import 'package:movies/features/movie/presentation/widgets/trend_item.dart';
import 'package:movies/shared/custom_field.dart';

class MoviesScreen extends StatelessWidget {
   MoviesScreen({super.key});
   MovieCubit movieCubit = getIt<MovieCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit,MovieStates>(
        bloc: movieCubit..getAllMovies(),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.appName,
                style: GoogleFonts.poppins(
                    fontSize: AppSize.s20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: AppSize.s0_5,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    ThemeCubit.get(context).toggleTheme();
                  },
                  icon: const Icon(Icons.brightness_4,size: 28),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppSize.s20),
              child: Column(
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: CustomField(
                        hintTxt: AppStrings.search,
                        suffixIcon: ImageIcon(AssetImage("assets/icons/Search.png")),
                    ),
                  ),
                  state is MovieLoaded
                  ? SizedBox(
                    height: 240,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie = state.getTrends[index];
                          return TrendItem(movie: movie, index: index) ;
                        },
                        separatorBuilder: (context, index) =>  Gap(8),
                        itemCount: state.getTrends.length
                    ),
                  )
                  : Center(child: CircularProgressIndicator()),
                  state is MovieLoaded
                  ? _MovieTabsView()
                  : CircularProgressIndicator()
                ],
              ),
            ),
          ) ;
        },
    );
  }
}



class _MovieTabsView extends StatefulWidget {
   _MovieTabsView({Key? key}) : super(key: key);

  @override
  State<_MovieTabsView> createState() => _MovieTabsViewState();
}

class _MovieTabsViewState extends State<_MovieTabsView> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<String> tabs = [
    AppStrings.nowPlaying,
    AppStrings.topRated,
    AppStrings.popular,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(tabs.length, (index) {
                final isSelected = _selectedIndex == index;
      
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        tabs[index],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold ,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 2,
                        width: 80,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.softGrey : Colors.transparent,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
      
          const SizedBox(height: 10),
      
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _selectedIndex = index);
                },
                children:  [
                  NowPlayWidget(),
                  TopRatedWidget(),
                  PopularWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}