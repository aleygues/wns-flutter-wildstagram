import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loading.dart';

const APIURL = "https://wildstagram.nausicaa.wilders.dev/upload";

class PictureScreen extends StatefulWidget {
  String path;

  PictureScreen({Key? key, required this.path}) : super(key: key);

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wildstagram'),
      ),
      body: Column(
        children: [
          Expanded(
            child: new Image.file(File(widget.path)),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: TextButton(
                  child: Text('Upload'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Loading.show(context, _keyLoader);
                    FormData formData = FormData.fromMap({
                      "fileData": await MultipartFile.fromFile(widget.path),
                      "name": "avatar"
                    });
                    dynamic response = await Dio().post(APIURL, data: formData);
                    Navigator.of(_keyLoader.currentContext!,
                            rootNavigator: true)
                        .pop();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
