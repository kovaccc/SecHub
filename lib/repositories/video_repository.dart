import 'dart:io';
import 'package:sechub/data/network/service/video_service.dart';
import 'package:injectable/injectable.dart';

/// \brief Repository for managing video data and uploading.
/// \details
///
/// @author Matej Kovacevic
/// @version 1.0
/// \date 26/01/2022
/// \copyright
///     This code and information is provided "as is" without warranty of
///     any kind, either expressed or implied, including but not limited to
///     the implied warranties of merchantability and/or fitness for a
///     particular purpose.
///
@singleton
class VideoRepository {
  final VideoService _videoService;

  VideoRepository(this._videoService);

  /// Sends [videoFile] to backend.
  Future<void> sendVideo(File videoFile) async {
    await _videoService.sendVideo(videoFile);
  }
}
