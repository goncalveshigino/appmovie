import 'package:appcinema/domain/entities/acttor_entity.dart';



abstract class ActorsDatasource {

   Future<List<ActorEntity>> getActorsByMovie(String movieId);

}