part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoSent extends VideoState {}

class VideoError extends VideoState {
  final Exception error;

  const VideoError(this.error);

  @override
  List<Object> get props => [error];
}
