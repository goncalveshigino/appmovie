import 'package:appcinema/domain/entities/acttor_entity.dart';



abstract class ActorsRepository {

   Future<List<ActorEntity>> getActorsByMovie(String movieId);
   
}