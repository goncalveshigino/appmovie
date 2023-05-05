import '../../domain/entities/acttor_entity.dart';
import '../models/moviedb/credits_response.dart';

class ActorMapper {
  static ActorEntity castToEntity(Cast cast) => 
  ActorEntity(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
        : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      character: cast.character
  );
}
