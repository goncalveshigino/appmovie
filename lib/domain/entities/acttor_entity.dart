

class ActorEntity {

  final int id;
  final String name;
  final String profilePath;
  final String? character; 


  ActorEntity({
    required this.id,
    required this.name,
    required this.profilePath,
    this.character,
  });


}
