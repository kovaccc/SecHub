import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sechub/blocs/video/video_bloc.dart';
import 'package:sechub/repositories/video_repository.dart';

import 'package:sechub/di/injection.dart';
import 'package:sechub/ui/scan_paint_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) =>
              VideoBloc(videoRepository: getIt<VideoRepository>()),
          child: const ScanPaintPage()),
    );
  }
}
