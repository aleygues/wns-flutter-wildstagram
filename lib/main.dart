import 'package:flutter/material.dart';
import 'package:wildstagram/screens/camera.dart';
import 'package:wildstagram/screens/gallery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wildstagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _TabsScreen(),
    );
  }
}

class _TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.collections)),
              Tab(icon: Icon(Icons.camera_alt)),
            ],
          ),
          title: Text('Wildstagram'),
        ),
        body: TabBarView(
          children: [
            GalleryScreen(),
            CameraScreen(),
          ],
        ),
      ),
    );
  }
}
