import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/movie/data/models/movie_model.dart';
import 'package:movies/features/movie/domain/repository/movie_repository.dart';

@injectable
class GetWishlistUseCase extends BaseUseCase<List<MovieModel>,NoParameters> {
  final MovieRepository baseMovieRepository;
  GetWishlistUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<MovieModel>>> call(NoParameters parameter)async {
    return await baseMovieRepository.getWishListMovie();

  }


}

@injectable
class AddToWishlistUseCase extends BaseUseCase<void, AddToWishlistParameters> {
  final MovieRepository baseMovieRepository;

  AddToWishlistUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, void>> call(AddToWishlistParameters parameter) async {
    return await baseMovieRepository.addToWishlist(parameter);
  }
}


@injectable
class RemoveFromWishlistUseCase extends BaseUseCase<void, RemoveFromWishlistParameters> {
  final MovieRepository baseMovieRepository;

  RemoveFromWishlistUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, void>> call(RemoveFromWishlistParameters parameter) async {
    return await baseMovieRepository.removeFromWishlist(parameter);
  }
}

class AddToWishlistParameters extends Equatable {
  final MovieModel movie;

  const AddToWishlistParameters({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class RemoveFromWishlistParameters extends Equatable {
  final int movieId;

  const RemoveFromWishlistParameters({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
