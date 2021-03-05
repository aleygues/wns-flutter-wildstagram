import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const IMAGES_URL = "https://api.cloudinary.com/v1_1/dy8inpbdc/resources/search";

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with AutomaticKeepAliveClientMixin<GalleryScreen> {
  List<String> _images;
  Timer _timer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _update();
    _timer = new Timer.periodic(new Duration(seconds: 5), (timer) {
      _update();
    });
  }

  @override
  dispose() {
    super.dispose();
    _timer.cancel();
  }

  _update() async {
    try {
      var auth = 'Basic ' +
          base64Encode(
              utf8.encode('681813489647456:NIm-xmnaF0kn3OKPX8yxorl82RU'));
      var result = await new Dio().get(IMAGES_URL,
          options: Options(headers: <String, String>{'authorization': auth}));
      var images = (result.data['resources'] as List<dynamic>)
          .map((entry) => entry['url'] as String)
          .toList();
      setState(() {
        this._images = images;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: _images == null
          ? Center(
              child: Text('Loading...'),
            )
          : ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10),
                  child: Image.network(
                    _images[index],
                    fit: BoxFit.fitWidth,
                  ),
                );
              },
            ),
    );
  }
}
