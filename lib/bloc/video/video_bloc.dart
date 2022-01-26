import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:sechub/repositories/video_repository.dart';

part 'video_event.dart';

part 'video_state.dart';

/// \brief State management class.
/// \details
///
/// @author  Matej Kovacevic
/// @version 1.0
/// \date 26/01/2022
/// \copyright
///     This code and information is provided "as is" without warranty of
///     any kind, either expressed or implied, including but not limited to
///     the implied warranties of merchantability and/or fitness for a
///     particular purpose.
///
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;

  VideoBloc({required this.videoRepository}) : super(VideoInitial()) {
    on<VideoUpload>(_onVideoUpload);
  }

  /// Emits [VideoSuccess] to UI if video [event.videoFile] is successfully uploaded to
  /// backend, otherwise emits [VideoError].
  void _onVideoUpload(VideoUpload event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    try {
      await videoRepository.sendVideo(event.videoFile);
      emit(VideoSuccess());
    } catch (e) {
      if (e is Exception) {
        emit(VideoError(e));
      }
    }
  }
}
