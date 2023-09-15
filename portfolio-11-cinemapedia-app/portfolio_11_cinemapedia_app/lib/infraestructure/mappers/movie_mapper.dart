import 'package:portfolio_11_cinemapedia_app/config/constants/environment.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/movie.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/models/moviedb/movie_db_movie_detail.dart';
import 'package:portfolio_11_cinemapedia_app/infraestructure/models/moviedb/movie_db_movie_response.dart';

class MovieMapper {
  static Movie movieDbToMovie(MovieMovieDb movieMovieDb) {
    return Movie(
      adult: movieMovieDb.adult,
      backdropPath: movieMovieDb.backdropPath != ''
          ? Environment.THE_MOVIE_DB_BASE_IMAGE_URL + movieMovieDb.backdropPath
          : Environment.NO_IMAGE_URL,
      genreIds: movieMovieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieMovieDb.id,
      originalLanguage: movieMovieDb.originalLanguage,
      originalTitle: movieMovieDb.originalTitle,
      overview: movieMovieDb.overview,
      popularity: movieMovieDb.popularity,
      posterPath: movieMovieDb.posterPath != ''
          ? Environment.THE_MOVIE_DB_BASE_IMAGE_URL + movieMovieDb.posterPath
          : Environment.NO_IMAGE_URL,
      releaseDate: movieMovieDb.releaseDate,
      title: movieMovieDb.title,
      video: movieMovieDb.video,
      voteAverage: movieMovieDb.voteAverage,
      voteCount: movieMovieDb.voteCount,
    );
  }

  static Movie movieDetailMovieDbToMovie(
      MovieDetailMovieDb movieDetailMovieDb) {
    return Movie(
      adult: movieDetailMovieDb.adult,
      backdropPath: movieDetailMovieDb.backdropPath != ''
          ? Environment.THE_MOVIE_DB_BASE_IMAGE_URL +
              movieDetailMovieDb.backdropPath
          : Environment.NO_IMAGE_URL,
      genreIds:
          movieDetailMovieDb.genres.map((e) => e.name.toString()).toList(),
      id: movieDetailMovieDb.id,
      originalLanguage: movieDetailMovieDb.originalLanguage,
      originalTitle: movieDetailMovieDb.originalTitle,
      overview: movieDetailMovieDb.overview,
      popularity: movieDetailMovieDb.popularity,
      posterPath: movieDetailMovieDb.posterPath != ''
          ? Environment.THE_MOVIE_DB_BASE_IMAGE_URL +
              movieDetailMovieDb.posterPath
          : Environment.NO_IMAGE_URL,
      releaseDate: movieDetailMovieDb.releaseDate,
      title: movieDetailMovieDb.title,
      video: movieDetailMovieDb.video,
      voteAverage: movieDetailMovieDb.voteAverage,
      voteCount: movieDetailMovieDb.voteCount,
    );
  }
}
