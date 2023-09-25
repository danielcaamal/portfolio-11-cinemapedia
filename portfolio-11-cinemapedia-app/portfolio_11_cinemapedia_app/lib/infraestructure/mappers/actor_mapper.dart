import 'package:portfolio_11_cinemapedia_app/config/constants/environment.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/actor.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/models/moviedb/movie_db_credits_response.dart';

class ActorMapper {
  static Actor castToActor(Cast cast) {
    return Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != '' && cast.profilePath != null
            ? Environment.THE_MOVIE_DB_BASE_IMAGE_URL + cast.profilePath!
            : Environment.NO_IMAGE_PROFILE_URL,
        character: cast.character);
  }
}
