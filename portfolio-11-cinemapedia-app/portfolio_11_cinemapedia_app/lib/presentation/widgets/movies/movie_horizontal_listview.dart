import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_11_cinemapedia_app/config/helpers/human_formats.dart';
import 'package:portfolio_11_cinemapedia_app/domain/entities/movie.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Column(children: [
        if (widget.title != null || widget.subtitle != null)
          _Title(
            title: widget.title,
            subtitle: widget.subtitle,
          ),
        const SizedBox(height: 5),
        Expanded(
            child: ListView.builder(
          controller: scrollController,
          itemCount: widget.movies.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => _Slide(
            movie: widget.movies[index],
          ),
        ))
      ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return GestureDetector(
                          child: FadeIn(child: child),
                          onTap: () => context.push('/movie/${movie.id}'));
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ));
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              movie.title,
              maxLines: 2,
              style: textTheme.titleSmall,
            ),
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(
                    Icons.star_half_outlined,
                    color: Colors.yellow.shade800,
                    size: 15,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    movie.voteAverage.toString(),
                    style: textTheme.bodyMedium!
                        .copyWith(color: Colors.yellow.shade800),
                  ),
                  const Spacer(),
                  Text(
                    HumanFormats.number(movie.popularity),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        if (title != null) Text(title!, style: titleStyle),
        const Spacer(),
        if (subtitle != null)
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            child: Text(subtitle!, style: subtitleStyle),
            onPressed: () => {},
          ),
      ]),
    );
  }
}
