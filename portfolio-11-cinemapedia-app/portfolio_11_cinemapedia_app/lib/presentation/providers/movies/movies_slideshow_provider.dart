import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/movie.dart';
import 'package:portfolio_11_cinemapedia_app/presentation/providers/movies/movies_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  return nowPlayingMovies.isNotEmpty ? nowPlayingMovies.sublist(0, 5) : [];
});
