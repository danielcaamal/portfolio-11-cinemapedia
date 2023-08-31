import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/domain/repositories/movies_repository.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/datasources/movie_db_datasource.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MovieRepositoryImpl(dataSource: MovieDbDataSource());
});
