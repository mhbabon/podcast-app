class Podcast {
  final String? audio;
  final String title;
  final String image;
  final String id;

  const Podcast({
    required this.audio,
    required this.title,
    required this.image,
    required this.id,
  });

  ///
  factory Podcast.fromJson(Map<String, dynamic> json) => Podcast(
    id: json['id']?.toString() ?? '',
    audio: json['audio'] ,
    title: json['title'] ?? ' No Title',
    image: json['image'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'audio': audio,
    'title': title,
    'image': image,
    'id': id,
  };
}
