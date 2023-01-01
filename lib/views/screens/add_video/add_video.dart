import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts_clone/constants.dart';
import 'package:shorts_clone/views/screens/confirm_video/confirm_video.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfirmVideoScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        ),
      ));
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (content) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: const [
                      Icon(Icons.image),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Gallery',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: Row(
                    children: const [
                      Icon(Icons.camera),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: const [
                      Icon(Icons.close),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Close',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        onTap: () => showOptionDialog(context),
        child: Container(
          width: 190,
          height: 50,
          decoration: BoxDecoration(color: buttonColor),
          child: const Center(
            child: Text(
              'Add Video',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )),
    );
  }
}
