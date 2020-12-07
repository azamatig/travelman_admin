import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CommentBloc extends ChangeNotifier{


  String timestamp1;
  String date;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  

  Future saveNewComment(String timestamp, String review, String collectionName) async{

    String _uid = 'admin'; // admin uid
    String _adminName = 'Admin'; //admin name
    String _imageUrl = 'https://img.icons8.com/bubbles/2x/admin-settings-male.png';  //admin icon url

    await _getDate()
    .then((value) => firestore
       .collection('$collectionName/$timestamp/comments')
       .doc('$_uid$timestamp1').set({
        'uid' : _uid,
        'name' : _adminName,
        'image url' : _imageUrl,
        'comment' : review,
        'date' : date,
        'timestamp' : timestamp1
       }));
    notifyListeners();

  }


  Future deleteComment (String timestamp, String uid, String timestamp2, String collectionName) async{
    await firestore.collection('$collectionName/$timestamp/comments').doc('$uid$timestamp2').delete();
    notifyListeners();
  }





  


  Future _getDate() async {
    DateTime now = DateTime.now();
    String _date = DateFormat('dd MMMM yy').format(now);
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    date = _date;
    timestamp1 = _timestamp;
  }


  Future<int> getTotalPlaceReviws (String timestamp) async {
    final DocumentReference ref = firestore.collection('places').doc(timestamp);
      DocumentSnapshot snap = await ref.get();
      int reviewsCount = snap['comments count'] ?? 0;
      return reviewsCount;
  }


  Future increaseCommmentsCount (String timestamp) async {
    await getTotalPlaceReviws(timestamp)
    .then((int documentCount)async {
      await firestore.collection('places')
      .doc(timestamp)
      .update({
        'comments count' : documentCount + 1
      });
    });
  }



  Future decreaseCommentsCount (String timestamp) async {
    await getTotalPlaceReviws(timestamp)
    .then((int documentCount)async {
      await firestore.collection('places')
      .doc(timestamp)
      .update({
        'comments count' : documentCount - 1
      });
    });
  }




}