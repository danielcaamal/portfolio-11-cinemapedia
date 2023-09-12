import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final moviesSlideShow = ref.watch(moviesSlideShowProvider).isEmpty;
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
  final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;
  return (moviesSlideShow ||
      nowPlayingMovies ||
      popularMovies ||
      upcomingMovies ||
      topRatedMovies);
});
