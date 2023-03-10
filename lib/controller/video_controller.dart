import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts_clone/constants.dart';
import 'package:shorts_clone/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(firestoreApp
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVideo = [];
      for (var element in query.docs) {
        retVideo.add(Video.fromSnap(element));
      }
      return retVideo;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc =
        await firestoreApp.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestoreApp.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestoreApp.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
