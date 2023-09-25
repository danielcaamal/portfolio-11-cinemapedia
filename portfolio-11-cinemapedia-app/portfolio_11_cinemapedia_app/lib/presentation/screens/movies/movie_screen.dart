import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/movie.dart';
import 'package:portfolio_11_cinemapedia_app/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:portfolio_11_cinemapedia_app/presentation/providers/movies/movie_detail_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailProvider.notifier).loadMovie(int.parse(widget.movieId));
    ref
        .read(actorsByMovieProvider.notifier)
        .loadActors(int.parse(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieDetailProvider);
    final Movie? movie = movies[int.parse(widget.movieId)];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return MovieDetailScreen(movie: movie);
  }
}

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _MovieDetails(movie: movie);
            },
            childCount: 1,
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  const _MovieDetails({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: textStyles.titleLarge,
                      ),
                      Text(
                        movie.overview,
                        style: textStyles.bodyMedium,
                        textAlign: TextAlign.left,
                      ),
                    ]),
              )
            ])),
        Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(children: [
              ...movie.genreIds
                  .map((gender) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Chip(
                        label: Text(gender.toString()),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )))
                  .toList()
            ])),
        _ActorsByMovie(movieId: movie.id),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final int movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider)[movieId];
    if (actorsByMovie == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorsByMovie.length,
        itemBuilder: (context, index) {
          final actor = actorsByMovie[index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  actor.profilePath,
                  fit: BoxFit.cover,
                  height: 180,
                  width: 135,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                actor.name,
                maxLines: 2,
              ),
              Text(
                'As ${actor.character ?? '-'}',
                maxLines: 2,
                style: const TextStyle(color: Colors.grey),
              ),
            ]),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // title: Text(
          //   movie.title,
          //   style: theme.textTheme.titleMedium?.copyWith(
          //     color: Colors.white,
          //   ),
          // ),
          background: Stack(children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return FadeIn(child: child);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.2, 0.7, 1],
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
                  ],
                ),
              )),
            )
          ])),
    );
  }
}
