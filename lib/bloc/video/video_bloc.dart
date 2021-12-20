import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:sechub/repositories/video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;

  VideoBloc({required this.videoRepository}) : super(VideoInitial()) {
    on<VideoUpload>(_onVideoUpload);
  }

  void _onVideoUpload(VideoUpload event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    try {
      await videoRepository.sendVideo(event.videoFile);
      emit(VideoSent());
    } catch (e) {
      if (e is Exception) {
        emit(VideoError(e));
      }
    }
  }
}
