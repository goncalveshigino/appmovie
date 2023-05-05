

import 'package:appcinema/infrastructure/datasources/actor_moviedb_datasource_impl.dart';
import 'package:appcinema/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref){
    return ActorRepositoryImpl( ActorMovieDbDatasourceImpl() );
});