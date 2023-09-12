import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Searching for the meaning of life',
      'Looking for the Holy Grail',
      'Asking Google about the answer to life, the universe and everything',
      'Looking for the meaning of life in the bottom of a bottle',
      'Trying to figure out what is the Matrix',
      'Cinepolis is not paying me to show you this message',
      'Loading...'
    ];
    return Stream.periodic(
            const Duration(milliseconds: 2000), (step) => messages[step])
        .take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  style: Theme.of(context).textTheme.caption,
                );
              }
              return const Text('Loading...');
            },
          )
        ],
      ),
    );
  }
}
