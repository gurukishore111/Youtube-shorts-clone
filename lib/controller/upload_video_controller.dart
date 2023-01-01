import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts_clone/constants.dart';
import 'package:shorts_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      Get.snackbar(
        'Getting Ready!',
        "Processing uploading steps 1/4",
        colorText: Colors.white,
      );
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestoreApp.collection('users').doc(uid).get();
      var allDocs = await firestoreApp.collection('videos').get();
      int len = allDocs.docs.length;
      Get.snackbar(
        'Uploading Processing!',
        "Processing uploading steps 2/4",
        colorText: Colors.white,
      );
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      Get.snackbar(
        'Generating Thumbnail!',
        "Processing uploading steps 3/4",
        colorText: Colors.white,
      );
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);
      Get.snackbar(
        'Saving Video!',
        "Processing uploading steps 4/4",
        colorText: Colors.white,
      );
      Video video = Video(
        username: (userDoc.data() as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
      );

      await firestoreApp
          .collection('videos')
          .doc("Video $len")
          .set(video.toJson());

      Get.snackbar(
        'Successfully Uploading!',
        "Your Video is streaming now",
        colorText: Colors.green.shade400,
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        colorText: Colors.red.shade400,
      );
    }
  }
}
