import 'package:dio/dio.dart';
import 'package:portfolio_11_cinemapedia_app/config/constants/environment.dart';
import 'package:portfolio_11_cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/actor.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/mappers/actor_mapper.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/models/moviedb/movie_db_credits_response.dart';

class ActorsMovieDbDataSource extends ActorsDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.THE_MOVIE_DB_BASE_URL,
    queryParameters: {
      'api_key': Environment.THE_MOVIE_DB_KEY,
      'language': 'en-US',
    },
  ));

  @override
  Future<List<Actor>> getActorsByMovieId(int movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    final List<Actor> actors =
        castResponse.cast.map((cast) => ActorMapper.castToActor(cast)).toList();
    return actors;
  }

  @override
  Future<Actor> getActorById(int actorId) async {
    throw UnimplementedError();
  }
}
