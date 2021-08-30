import 'package:flutter/material.dart';
import 'package:flutter_application_1/camera.dart';
import 'package:flutter_application_1/gallery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(icon: Icon(Icons.collections))
            ],
          ),
          title: Text('Wildstagram'),
        ),
        body: TabBarView(
          children: [
            CameraScreen(),
            GalleryScreen(),
          ],
        ),
        //floatingActionButton: FloatingActionButton(
        //  child: Icon(Icons.photo_camera),
        //),
      ),
    );
  }
}
