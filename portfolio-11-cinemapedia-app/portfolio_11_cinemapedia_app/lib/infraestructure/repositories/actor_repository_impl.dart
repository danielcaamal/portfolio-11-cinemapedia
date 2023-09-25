import 'package:portfolio_11_cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/actor.dart';
import 'package:portfolio_11_cinemapedia_app/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDataSource dataSource;
  ActorRepositoryImpl({required this.dataSource});

  @override
  Future<Actor> getActorById(int actorId) {
    return dataSource.getActorById(actorId);
  }

  @override
  Future<List<Actor>> getActorsByMovieId(int movieId) {
    return dataSource.getActorsByMovieId(movieId);
  }
}
