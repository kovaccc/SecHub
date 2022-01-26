part of 'video_bloc.dart';

/// \brief Video states holder, used in BLoC architecture to emit states
/// from BLoC class to UI.
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
abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

/// Initial state.
class VideoInitial extends VideoState {}

/// State used to show loading progress on screen.
class VideoLoading extends VideoState {}

/// State used to determine success of uploading video to backend.
class VideoSuccess extends VideoState {}

/// State used to show error when uploading video to backend.
class VideoError extends VideoState {
  final Exception error;

  const VideoError(this.error);

  @override
  List<Object> get props => [error];
}
