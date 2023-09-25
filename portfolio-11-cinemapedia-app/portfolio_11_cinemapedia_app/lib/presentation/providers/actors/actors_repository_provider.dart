import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/domain/repositories/actors_repository.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/datasources/actors_movie_db_datasource.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/repositories/actor_repository_impl.dart';

final actorRepositoryProvider = Provider<ActorsRepository>((ref) {
  return ActorRepositoryImpl(dataSource: ActorsMovieDbDataSource());
});
