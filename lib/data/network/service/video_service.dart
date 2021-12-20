import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:sechub/common/base/base_service.dart';
import 'package:sechub/data/network/rest_client.dart';

@singleton
class VideoService extends BaseService {
  final RestClient _restClient;

  VideoService(this._restClient);

  Future<void> sendVideo(File videoFile) async {
    await apiRequest(apiCall: _restClient.sendVideo(videoFile));
  }
}
