import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/movie.dart';
import 'package:portfolio_11_cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MoviesNotifier(movieCallBack: movieRepository.getNowPlayingMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MoviesNotifier(movieCallBack: movieRepository.getPopularMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MoviesNotifier(movieCallBack: movieRepository.getUpcomingMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MoviesNotifier(movieCallBack: movieRepository.getTopRatedMovies);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack movieCallBack;
  MoviesNotifier({
    required this.movieCallBack,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;

    final newMovies = await movieCallBack(page: currentPage);
    state = [...state, ...newMovies];
    await Future.delayed(const Duration(milliseconds: 250));
    isLoading = false;
  }
}
