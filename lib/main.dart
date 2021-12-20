import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sechub/bloc/video/video_bloc.dart';
import 'package:sechub/repositories/video_repository.dart';

import 'package:sechub/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) =>
              VideoBloc(videoRepository: getIt<VideoRepository>()),
          child: const RecordVideoPage()),
    );
  }
}

class RecordVideoPage extends StatefulWidget {
  const RecordVideoPage({Key? key}) : super(key: key);

  @override
  State<RecordVideoPage> createState() => _RecordVideoPageState();
}

class _RecordVideoPageState extends State<RecordVideoPage> {
  late CameraController controller;
  bool isCameraRecording = false;

  @override
  void initState() {
    super.initState();
    //checkCameraPermission();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> recordVideo() async {
    print("Start");
    // controller.startVideoRecording();
    await Future.delayed(const Duration(seconds: 3));
    if (isCameraRecording) {
      print("Stop");
      // XFile xFile = await controller.stopVideoRecording();
      // File file = File(xFile.path);
      // BlocProvider.of<VideoBloc>(context)
      //     .add(VideoUpload(file));
      recordVideo();
    }
  }

  Future<CameraController> initCameraController() async {
    List<CameraDescription> cameras = await availableCameras();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );
    await controller.initialize();
    await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FutureBuilder<CameraController>(
                  future: initCameraController(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState != ConnectionState.done
                          ? Container()
                          : CameraPreview(controller),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (isCameraRecording) {
                          isCameraRecording = false;
                          print("Stop right now");
                          // XFile xFile = await controller.stopVideoRecording();
                          // File file = File(xFile.path);
                          // BlocProvider.of<VideoBloc>(context)
                          //     .add(VideoUpload(file));
                        } else {
                          isCameraRecording = true;
                          recordVideo();
                        }
                      },
                      child: SafeArea(
                        top: false,
                        child: Container(
                          width: 74,
                          height: 74,
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.all(3.4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.transparent,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
