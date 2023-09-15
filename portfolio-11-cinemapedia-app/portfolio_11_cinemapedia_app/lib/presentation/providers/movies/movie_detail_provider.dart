import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/movie.dart';
import 'package:portfolio_11_cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';

final movieDetailProvider =
    StateNotifierProvider<MovieMapNotifier, Map<int, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(int id);

class MovieMapNotifier extends StateNotifier<Map<int, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(int id) async {
    if (state[id] != null) return;
    final movie = await getMovie(id);
    _addMovie(movie);
  }

  void _addMovie(Movie movie) {
    state = {
      ...state,
      movie.id: movie,
    };
  }
}
