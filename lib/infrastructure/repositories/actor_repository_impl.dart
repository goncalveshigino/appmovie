import 'package:appcinema/domain/domain.dart';



class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource actorsDatasource;
  ActorRepositoryImpl(this.actorsDatasource);



  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) {
    return actorsDatasource.getActorsByMovie(movieId);
  }

}