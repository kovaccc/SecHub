import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sechub/bloc/video/video_bloc.dart';
import 'package:sechub/common/widgets/dialogs.dart';
import 'package:sechub/util/errorhandler.dart';

class ScanPaintPage extends StatefulWidget {
  const ScanPaintPage({Key? key}) : super(key: key);

  @override
  State<ScanPaintPage> createState() => _ScanPaintPageState();
}

class _ScanPaintPageState extends State<ScanPaintPage> {
  late CameraController controller;
  bool showCameraPermissionDialog = false;
  bool isButtonActive = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
    return BlocListener<VideoBloc, VideoState>(
      listenWhen: (previousState, state) {
        return previousState is VideoLoading || state is VideoLoading;
      },
      listener: (context, state) {
        if (state is VideoLoading) {
          showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          if (state is VideoSuccess) {
            showErrorDialog(
              context,
              "Status",
              "Video is uploaded successfully",
            );
          } else if (state is VideoError) {
            showErrorDialog(
              context,
              "Upload error",
              ErrorHandler.resolveExceptionMessage(state.error),
            );
          }
        }
      },
      child: Scaffold(
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
                        onTapDown: (_) async {
                          if (!showCameraPermissionDialog) {
                            controller.startVideoRecording();
                          }
                        },
                        onTapUp: (_) async {
                          XFile xFile = await controller.stopVideoRecording();
                          File file = File(xFile.path);
                          BlocProvider.of<VideoBloc>(context)
                              .add(VideoUpload(file));
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
      ),
    );
  }
}
