import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wildstagram/screens/picture.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with AutomaticKeepAliveClientMixin<CameraScreen> {
  CameraController _controller;
  Future<void> _initialized;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initialized = _initCamera();
  }

  _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    await _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: CameraPreview(_controller),
                ),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text('Shot!'),
                  onPressed: () async {
                    print("Take a shot");
                    try {
                      await _initialized;
                      final image = await _controller.takePicture();
                      print(image.path);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PictureScreen(
                            image.path,
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text('Loading camera...'),
          );
        }
      },
    );
  }
}
