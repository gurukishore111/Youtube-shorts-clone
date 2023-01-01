import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts_clone/controller/auth_controller.dart';
import 'package:shorts_clone/views/screens/add_video/add_video.dart';
import 'package:shorts_clone/views/screens/profile_screen/profile_screen.dart';
import 'package:shorts_clone/views/screens/search_screen/search_screen.dart';
import 'package:shorts_clone/views/screens/videos/video.dart';

// pages
List navigatePages(String uid) {
  return [
    VideoScreen(),
    SearchScreen(),
    const AddVideoScreen(),
    const Text(
        'Messages Screen'), // this is to do .. I will add chat functionality..
    ProfileScreen(uid: uid),
  ];
}

// firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestoreApp = FirebaseFirestore.instance;

// Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// controller
var authController = AuthController.instance;
