//Provider se esta ou nao em favorito
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localstorageRepository = ref.watch(localStorageRepositoryProvider);
  return localstorageRepository.isMovieFavorite(movieId);
});