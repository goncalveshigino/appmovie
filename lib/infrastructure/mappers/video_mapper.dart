
import '../../domain/entities/video_entity.dart';
import '../models/models.dart';

class VideoMapper {

  static moviedbVideoToEntity( Result moviedbVideo ) => VideoEntity(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt
  );


}