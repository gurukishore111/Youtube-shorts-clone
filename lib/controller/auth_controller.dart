import "dart:io";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts_clone/constants.dart';
import 'package:shorts_clone/models/user.dart' as models;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;

  // pick image from gallery
  void pickImageFromGallery() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      Get.snackbar(
        'Profile Picture',
        'You have successfully selected your profile picture!',
        colorText: Colors.red.shade400,
      );
    }
    _pickedImage = Rx<File?>(File(pickedImg!.path));
  }

  // upload to firebase
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
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
        print(email + "✅" + password);
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
        print(cred);
        String imageUrl = await _uploadToStorage(image);
        models.User user = models.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: imageUrl,
        );
        print(imageUrl);
        await firestoreApp
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        Get.snackbar(
          'Successfully register 🎉!',
          'Your account has been successfully created.',
          colorText: Colors.green.shade400,
        );
      } else {
        Get.snackbar(
          'Error creating account',
          'Please enter all the fields',
          colorText: Colors.red.shade400,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        colorText: Colors.red.shade400,
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password);
        Get.snackbar(
          'Login Successfully🎉!',
          'Now you good to go',
          colorText: Colors.green.shade400,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        colorText: Colors.red.shade400,
      );
    }
  }
}
