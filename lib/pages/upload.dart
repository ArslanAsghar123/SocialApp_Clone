import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 680, maxWidth: 960);
    setState(() {
      this.file = file;
    });
  }

  handleChooseFromGallery() async{

    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
        source: ImageSource.gallery );
    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('create post'),
            children: [
              SimpleDialogOption(
                child: Text('photo with camera'),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text('Image from gallery'),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text('cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Container buildSplashScreen() {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 28.0),
            child: Image.asset(
              'assets/images/upload.png',
              height: 260,
            ),
          ),
          GestureDetector(
            onTap: () => selectImage(context),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Center(
                  child: Text(
                    'upload Image',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildUploadForm(){
    return Text('File Uploaded');
  }

  @override
  Widget build(BuildContext context) {
    return file == null? buildSplashScreen():buildUploadForm();
  }
}
