import 'package:appcinema/domain/entities/acttor_entity.dart';



abstract class ActorsEntity {

   Future<List<ActorEntity>> getActorsByMovie(String movieId);
   
}