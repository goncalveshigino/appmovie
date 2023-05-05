import 'package:dio/dio.dart';
import '../../config/constants/environment.dart';
import '../../domain/domain.dart';
import '../models/moviedb/credits_response.dart';
import 'package:appcinema/infrastructure/infrastructure.dart';



class ActorMovieDbDatasourceImpl extends ActorsDatasource {

  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'pt-Pt'
      }));

  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<ActorEntity> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
