import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/layout/screen/splash.dart';
import 'package:movies/core/theme/theme.dart';
import 'package:movies/core/themes/theme_cubit.dart';
import 'package:movies/core/themes/theme_state.dart';
import 'package:movies/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/di.dart';
import 'core/local/cache_helper.dart';
import 'features/movie/presentation/cubit/movie_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await CacheHelper.init();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? false;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MovieCubit>()),
        BlocProvider(create: (_) => FavoritesCubit()),
      ],
      child: BlocProvider(
          create: (context) => ThemeCubit(isDark),
          child: const MyApp()
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightMode,
          darkTheme: AppThemes.darkMode,
          themeMode: state.themeMode,
          home: MovieSplashScreen(),
        );
      },
    );
  }
}




