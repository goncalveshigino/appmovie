import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/domain.dart';

class IsarDatasourceImpl extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasourceImpl() {
    db = onpenDB();
  }

  Future<Isar> onpenDB() async {
    
   final Directory dir = await getApplicationDocumentsDirectory();

    Directory('${dir.path}/dir').create(recursive: true)
// The created directory is returned as a Future.
    .then((Directory directory) {
  print('Path of New Dir: '+directory.path);
});

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        MovieEntitySchema,
      ], inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final MovieEntity? isFavoriteMovie =
        await isar.movieEntitys.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movieEntitys.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toogleFavorite(MovieEntity movieEntity) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movieEntitys.filter().idEqualTo(movieEntity.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(
          () => isar.movieEntitys.deleteSync(favoriteMovie.isarId!));
    }

    isar.writeTxnSync(() => isar.movieEntitys.putSync(movieEntity));
  }
}
