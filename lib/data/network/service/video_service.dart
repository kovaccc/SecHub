import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:sechub/common/base/base_service.dart';
import 'package:sechub/data/network/rest_client.dart';

/// \brief Service class used for communicating with the backend for
/// video uploading.
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
class VideoService extends BaseService {
  final RestClient _restClient;

  VideoService(this._restClient);

  /// Send [videoFile] to backend.
  Future<void> sendVideo(File videoFile) async {
    await apiRequest(apiCall: _restClient.sendVideo(videoFile));
  }
}
