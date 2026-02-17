import 'package:injectable/injectable.dart';
import 'package:movies/core/error/execption.dart';
import 'package:movies/core/local/cache_helper.dart';
import 'package:movies/core/network/dio_helper.dart';
import 'package:movies/core/utils/app_constants.dart';
import 'package:movies/features/movie/data/models/movie_details_model.dart';
import 'package:movies/features/movie/data/models/movie_model.dart';
import 'movie_remote_data_source.dart';

@Injectable(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlaying()async{
    final response = await DioHelper.getData(url: AppConstants.nowPlayingPath);
    if(response.statusCode == 200){
      CacheHelper.saveData(key: "cachedNowPlayingLocalData", value: response.data.toString());
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else{
      throw ServerException("no data found ${response.data}");
    }
  }

  @override
  Future<List<MovieModel>> getPopular()async{
    final response = await DioHelper.getData(url: AppConstants.popularPlayingPath);
    if(response.statusCode == 200){
      CacheHelper.saveData(key: "cachedPopularLocalData", value: response.data.toString());
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else{
      throw ServerException("no data found ${response.data}");
    }
  }

  @override
  Future<List<MovieModel>> getTopRated()async{
    final response = await DioHelper.getData(url: AppConstants.getTopRatedMoviePath);
    if(response.statusCode == 200){
      CacheHelper.saveData(key: "cachedTopRatedLocalData", value: response.data.toString());
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else{
      throw ServerException("no data found ${response.data}");
    }
  }

  @override
  Future<List<MovieModel>> getTrend()async{
    final response = await DioHelper.getData(url: AppConstants.trendPath);
    if(response.statusCode == 200){
      CacheHelper.saveData(key: "cachedTrendLocalData", value: response.data.toString());
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else{
      throw ServerException("no data found ${response.data}");
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId)async{
    final response = await DioHelper.getData(url: AppConstants.getMovieDetailsPath(movieId));
    if(response.statusCode == 200){
      CacheHelper.saveData(key: "cachedMovieDetailsLocalData", value: response.data.toString());
      return MovieDetailsModel.fromJson(response.data) ;
    }
    else{
      throw ServerException("no data found ${response.data}");
    }
  }

  @override
  Future<List<MovieModel>> getSearchMovie(String title)async{
    final response = await DioHelper.getData(url: AppConstants.getSearchPath(title));
    if(response.statusCode == 200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else{
      throw ServerException("no data found ${response.data}");
    }
  }
}