import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const API_URL = "https://api.cloudinary.com/v1_1/dy8inpbdc/image/upload";

class PictureScreen extends StatefulWidget {
  final String imagePath;

  PictureScreen(this.imagePath);

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  bool _uploading = false;

  _upload() async {
    setState(() {
      _uploading = true;
    });

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(widget.imagePath),
      "upload_preset": "wcspreset",
    });
    await new Dio().post(API_URL, data: formData);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your picture'),
        ),
        body: _uploading == true
            ? Center(
                child: Text('Uploading...'),
              )
            : Column(
                children: [
                  Expanded(
                    child: Image.file(
                      new File(widget.imagePath),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text('Upload'),
                          onPressed: () {
                            _upload();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ));
  }
}
