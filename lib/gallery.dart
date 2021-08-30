import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const IMAGES_URL = "https://wildstagram.nausicaa.wilders.dev/list";

class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key? key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with AutomaticKeepAliveClientMixin<GalleryScreen> {
  List<String?> _images = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _update();

    Timer.periodic(new Duration(seconds: 4), (timer) {
      _update();
    });
  }

  _update() async {
    Response<dynamic> result = await Dio().get(
      IMAGES_URL,
    );
    setState(() {
      try {
        this._images = (result.data as List<dynamic>)
            .map((entry) =>
                "https://wildstagram.nausicaa.wilders.dev/files/$entry")
            .toList();
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: this._images.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              this._images[index]!,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }
}
