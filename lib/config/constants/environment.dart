import 'package:flutter_dotenv/flutter_dotenv.dart';


class Environment {

   static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'Nao ha uma key da api';

}