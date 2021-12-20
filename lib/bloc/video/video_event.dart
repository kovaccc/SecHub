
part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();
}

class VideoUpload extends VideoEvent {
  final File videoFile;

  const VideoUpload(this.videoFile);

  @override
  List<Object> get props => [videoFile];
}
