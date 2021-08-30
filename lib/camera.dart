import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/picture.dart';

const APIURL = "https://api.cloudinary.com/v1_1/dy8inpbdc/image/upload";

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with AutomaticKeepAliveClientMixin<CameraScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _init();
  }

  _init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    await _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Column(
            children: [
              Expanded(
                child: CameraPreview(_controller),
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    XFile image = await _controller.takePicture();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PictureScreen(path: image.path),
                      ),
                    );
                  },
                  child: Text('Click me'),
                ),
              )
            ],
          );
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
