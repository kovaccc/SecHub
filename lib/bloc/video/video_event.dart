part of 'video_bloc.dart';

/// \brief Video events holder, used in BLoC architecture to start actions
/// in BLoC class.
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
abstract class VideoEvent extends Equatable {
  const VideoEvent();
}

/// Event to start uploading [videoFile] to backend.
class VideoUpload extends VideoEvent {
  final File videoFile;

  const VideoUpload(this.videoFile);

  @override
  List<Object> get props => [videoFile];
}
