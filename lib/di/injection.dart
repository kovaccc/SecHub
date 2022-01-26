import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

/// \brief Dependency injection functions.
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

/// Instance of dependency injection locator. Use it to fetch
/// all classes included in dependency injection.
final getIt = GetIt.instance;

/// Generates all dependencies annotated in project.
@injectableInit
void configureDependencies() {
  $initGetIt(getIt);
}
