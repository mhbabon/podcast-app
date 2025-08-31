import 'package:flutter/material.dart';
import 'package:podcast_app/model/podcast.dart';

import '../../api/podcast_api.dart';

class PodcastItem extends StatefulWidget {
  final Podcast podcast;

  const PodcastItem({super.key, required this.podcast});

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(
      widget.podcast.title,
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
    trailing: IconButton(
        onPressed: () async {

final audioUrl = widget.podcast.audio;

if (audioUrl == null || audioUrl.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('❌ Audio URL not available for "${widget.podcast.title}"'),
    ),
  );
  return;
}

final path = '${widget.podcast.title}/${widget.podcast.id}.mp3';

await PodcastApi().downloadAudio(
  audioUrl,
  path,
  onReceiveProgress: (count, total) {
    debugPrint('$count/$total');
  },
);




        //
        //   final path = '${widget.podcast.title}/${widget.podcast.id}.mp3';
        //   await PodcastApi().downloadAudio(
        //    audioUrl!,
        //     path,
        //     onReceiveProgress: (count, total) {
        //       debugPrint('$count/$total');
        //     },
        //   );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('⏳ Downloading "${widget.podcast.title}"...'),
            ),
          );
  },
        icon: Icon(Icons.download)),
    leading: Image.network(
      widget.podcast.image,
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    ),
  );
}

