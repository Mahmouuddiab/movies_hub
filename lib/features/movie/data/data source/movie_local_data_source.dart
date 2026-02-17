import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:movies/core/error/execption.dart';
import 'package:movies/core/local/cache_helper.dart';
import 'package:movies/features/movie/data/models/movie_details_model.dart';
import 'package:movies/features/movie/data/models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getTrendLocalData();
  Future<List<MovieModel>> getNowPlayingLocalData();
  Future<List<MovieModel>> getPopularLocalData();
  Future<List<MovieModel>> getTopRatedLocalData();
  Future<MovieDetailsModel> getMovieDetailsLocalData(int movieId);
  Future<List<MovieModel>> getWishLocalData();

  Future<void> cachedTrendLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedNowPlayingLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedPopularLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedTopRatedLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedMovieDetailsLocalData({required  MovieDetailsModel  movieDetailsModel});
  Future<void> cachedWishLocalData({required  List<MovieModel>  movieModel});
}

@Injectable(as: MovieLocalDataSource)
class MovieLocalDataSourceImpl implements MovieLocalDataSource{
  @override
  Future<void> cachedNowPlayingLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(key: "cachedNowPlayingLocalData", value: jsonEncode(movieModel.toList())) ;
  }

  @override
  Future<void> cachedPopularLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(key: "cachedPopularLocalData", value: jsonEncode(movieModel.toList()));
  }

  @override
  Future<void> cachedTopRatedLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(key: "cachedTopRatedLocalData", value: jsonEncode(movieModel.toList()));
  }

  @override
  Future<void> cachedTrendLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(key: "cachedTrendLocalData", value: jsonEncode(movieModel.toList()));
  }

  @override
  Future<List<MovieModel>> getNowPlayingLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedNowPlayingLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    }
    else{
      throw  LocalExceptions(message: "no data");
    }
  }

  @override
  Future<List<MovieModel>> getPopularLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedPopularLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    }
    else{
      throw  LocalExceptions(message: "no data");
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedTopRatedLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    }
    else{
      throw  LocalExceptions(message: "no data");
    }
  }

  @override
  Future<List<MovieModel>> getTrendLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedTrendLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    }
    else{
      throw  LocalExceptions(message: "no data");
    }
  }

  @override
  Future<void> cachedMovieDetailsLocalData({required MovieDetailsModel movieDetailsModel}) {
   return CacheHelper.saveData(key: "cachedMovieDetailsLocalData", value: jsonEncode(movieDetailsModel)) ;
  }

  @override
  Future<MovieDetailsModel> getMovieDetailsLocalData(int movieId) {
    final jsonString = CacheHelper.getData(key: 'cachedMovieDetailsLocalData');
    if(jsonString != null){
      final cachedDetailsData = List<MovieDetailsModel>.from(
          (json.decode(jsonString)).map((e) => MovieDetailsModel.fromJson(e),));
      return Future.value(cachedDetailsData as FutureOr<MovieDetailsModel>?) ;
    }

    else{
      throw  LocalExceptions(message: "no data");
    }
  }

  @override
  Future<void> cachedWishLocalData({required List<MovieModel> movieModel}){
    final List<Map<String, dynamic>> jsonList =
    movieModel.map((movie) => (movie).toJson()).toList();
    return CacheHelper.saveData(
        key: 'cachedWishLocalData',
        value: jsonEncode(jsonList)
    );
  }

  @override
  Future<List<MovieModel>> getWishLocalData()async{
    final jsonString = CacheHelper.getData(key: 'cachedWishLocalData');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      return jsonList
          .map((json) => MovieModel.fromJson(json))
          .toList();
    } else {
      return Future.value([]);
    }
  }

  
  
}