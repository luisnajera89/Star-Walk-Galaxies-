import 'dart:ffi';
import 'package:first_app_9/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakenPictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakenPictureScreen({super.key, required this.camera});

  @override
  State<TakenPictureScreen> createState() => _TakenPictureScreenState();
}

class _TakenPictureScreenState extends State<TakenPictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.camera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture of the galaxy'),
        backgroundColor: Color.fromARGB(255, 56, 125, 252),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 196, 196, 196),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await _controller.takePicture();
            Directory? documentDirectory = await getExternalStorageDirectory();
            String path = join(documentDirectory!.path, image.name);
            image.saveTo(path);

            if (!mounted) {
              return;
            }

            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(
                      ImagePhath: image.path,
                      firstCamera: widget.camera,
                    )));
          } catch (e) {
            print(e);
          }
        },
        backgroundColor: Color.fromARGB(255, 56, 125, 252),
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}
