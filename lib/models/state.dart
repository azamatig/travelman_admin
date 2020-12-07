import 'package:cloud_firestore/cloud_firestore.dart';

class StateModel {
  String name;
  String thumbnailUrl;
  String timestamp;

  StateModel({
    this.name,
    this.thumbnailUrl,
    this.timestamp
  });


  factory StateModel.fromFirestore(DocumentSnapshot snapshot){
    var d = snapshot.data();
    return StateModel(
      name: d['name'],
      thumbnailUrl: d['thumbnail'],
      timestamp: d['timestamp'],
    );
  }
}