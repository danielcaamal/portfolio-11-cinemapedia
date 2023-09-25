import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/actor.dart';
import 'package:portfolio_11_cinemapedia_app/presentation/providers/actors/actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<int, List<Actor>>>((ref) {
  final actorRepository = ref.watch(actorRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorRepository.getActorsByMovieId);
});

typedef GetActorsCallback = Future<List<Actor>> Function(int movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<int, List<Actor>>> {
  final GetActorsCallback getActors;
  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(int movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActors(movieId);
    state = {
      ...state,
      movieId: actors,
    };
  }
}
