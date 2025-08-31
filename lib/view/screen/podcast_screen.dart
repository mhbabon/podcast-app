import 'package:flutter/material.dart';
import 'package:podcast_app/view/widget/podcast_item.dart';

import '../../api/podcast_api.dart';
import '../../model/podcast.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  List<Podcast>? podcasts;
  final podcastApi = PodcastApi();

  @override
  void initState() {
    super.initState();
    fetchPodcasts();
  }

  Future<void> fetchPodcasts() async {
    podcasts = await podcastApi.fetchPodcasts();
    print(podcasts);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Podcast"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: podcasts == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: podcasts!.length,
                separatorBuilder: (_, _) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final podcast = podcasts![index];
                  return PodcastItem(podcast: podcast);
                },
              ),
      ),
    );
  }
}
