import "dart:io";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shorts_clone/constants.dart';

class AuthController extends GetxController {
  // upload to firebase
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('ProfilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String url = await snap.ref.getDownloadURL(); // imageUrl
    return url;
  }

  // registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save out user
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String imageUrl = await _uploadToStorage(image);
      }
    } catch (e) {
      Get.snackbar('Error creating account', e.toString());
    }
  }
}
