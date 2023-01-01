import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts_clone/controller/auth_controller.dart';
import 'package:shorts_clone/views/screens/add_video/add_video.dart';
import 'package:shorts_clone/views/screens/videos/video.dart';

// pages
const pages = [
  VideoScreen(),
  Text('Search Screen'),
  AddVideoScreen(),
  Text('Message Screen'),
  Text('Profile Screen'),
];

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
