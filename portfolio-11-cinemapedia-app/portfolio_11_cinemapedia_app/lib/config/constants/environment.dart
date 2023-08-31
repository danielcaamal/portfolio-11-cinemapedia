import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String THE_MOVIE_DB_KEY =
      dotenv.env['THE_MOVIE_DB_KEY'] ?? 'No key found';

  static String THE_MOVIE_DB_BASE_URL =
      dotenv.env['THE_MOVIE_DB_BASE_URL'] ?? 'No url found';

  static String THE_MOVIE_DB_BASE_IMAGE_URL =
      dotenv.env['THE_MOVIE_DB_BASE_IMAGE_URL'] ?? 'No url found';

  static String NO_IMAGE_URL = dotenv.env['NO_IMAGE_URL'] ?? 'No url found';
}
