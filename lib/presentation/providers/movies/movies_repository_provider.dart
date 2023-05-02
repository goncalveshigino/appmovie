

import 'package:appcinema/infrastructure/datasources/moviedb_datasource_impl.dart';
import 'package:appcinema/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Este repositorio e inmutable
final movieRepositoryProvider = Provider((ref){
    return MovieRepositoryImpl( MoviedbDatasourceImpl() );
});