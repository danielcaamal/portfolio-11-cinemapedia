import 'package:portfolio_11_cinemapedia_app/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovieId(int movieId);
  Future<Actor> getActorById(int actorId);
}
