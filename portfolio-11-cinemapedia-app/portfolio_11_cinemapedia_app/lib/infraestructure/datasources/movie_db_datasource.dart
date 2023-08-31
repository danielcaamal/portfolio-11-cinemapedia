import 'package:dio/dio.dart';

import 'package:portfolio_11_cinemapedia_app/config/constants/environment.dart';
import 'package:portfolio_11_cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/movie.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/mappers/movie_mapper.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/models/moviedb/movie_db_response.dart';

class MovieDbDataSource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.THE_MOVIE_DB_BASE_URL,
    queryParameters: {
      'api_key': Environment.THE_MOVIE_DB_KEY,
      'language': 'en-US',
    },
  ));

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != '')
        .map((movieMovieDb) => MovieMapper.movieDbToMovie(movieMovieDb))
        .toList();

    return movies;
  }
}
