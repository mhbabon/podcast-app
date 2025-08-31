import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/podcast.dart';

class PodcastApi {
  Future<List<Podcast>> fetchPodcasts() async {
    const url = 'https://listen-api.listennotes.com/api/v2/best_podcasts';
    const apiKey = '19ca6be034224247b9486461e0742418';

    final headers = {'X-ListenAPI-Key': apiKey, 'Accept': 'application/json'};

    if (await InternetConnectionChecker.instance.hasConnection) {
      final response = await Dio().get(url, options: Options(headers: headers));

      print("🔍 Full API Response:");
      print(response.data); // << এই লাইনটি আসল রহস্য দেখাবে

      final results = response.data['podcasts'] as List;
      print("👉 Podcasts length: ${results.length}");
      print("👉 podcast json: $json"); // << প্রতিটি আইটেম প্রিন্ট করুন

      final podcasts = results.map((json) => Podcast.fromJson(json)).toList();
      return podcasts;
    } else {
      return [];
    }
  }

  Future<void> downloadAudio(
      String url,
      String fileName,
       {
    ProgressCallback? onReceiveProgress,
  }) async {

    print("🔗 Download URL: $url");
    print("📄 File Name: $fileName");


    final appStorage = await getApplicationDocumentsDirectory();
    final sharedPreferences = await SharedPreferences.getInstance();
    final path = '${appStorage.path}/$fileName';
    print("📁 App document path: $path");

    if(await InternetConnectionChecker.instance.hasConnection){
      await Dio().download(
        url,
        path,
        onReceiveProgress: onReceiveProgress,
      );
      await sharedPreferences.setString('path', path);
    }



  }


}
