import 'dart:io';
import 'package:sechub/data/network/service/video_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class VideoRepository {
  final VideoService _videoService;

  VideoRepository(this._videoService);

  Future<void> sendVideo(File videoFile) async {
    await _videoService.sendVideo(videoFile);
  }
}
