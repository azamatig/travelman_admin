
import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {

  String title;
  String description;
  String thumbnailImagelUrl;
  int loves;
  String sourceUrl;
  String date;
  String timestamp;

  Blog({

    this.title,
    this.description,
    this.thumbnailImagelUrl,
    this.loves,
    this.sourceUrl,
    this.date,
    this.timestamp
    
  });


  factory Blog.fromFirestore(DocumentSnapshot snapshot){
    var d = snapshot.data();
    return Blog(
      title: d['title'],
      description: d['description'],
      thumbnailImagelUrl: d['image url'],
      loves: d['loves'],
      sourceUrl: d['source'],
      date: d['date'],
      timestamp: d['timestamp'], 


    );
  }
}