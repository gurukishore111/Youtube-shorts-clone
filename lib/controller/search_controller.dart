import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts_clone/constants.dart';
import 'package:shorts_clone/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(firestoreApp
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var elem in query.docs) {
        retVal.add(User.fromSnap(elem));
      }
      // return retVal;
      List<User> outputList =
          retVal.where((item) => item.uid != authController.user.uid).toList();
      return outputList;
      // There was a bug where a search list returns the auth user when you type in the auth user name.
    }));
  }
}
