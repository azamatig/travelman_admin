import 'package:cloud_firestore/cloud_firestore.dart';

class BookingCard{
  String hotelName;
  String price;
  String imageUrl;
  String depDate;
  String arrDate;

  BookingCard({this.hotelName, this.price,
    this.imageUrl, this.depDate, this.arrDate});
  
  factory BookingCard.fromFirestore(DocumentSnapshot snapshot){
    var d = snapshot.data();
    return BookingCard(
      hotelName: d['hotelName'],
      price: d['price'],
      imageUrl: d['imageUrl'],
      depDate: d['depDate'],
      arrDate: d['arrDate'],
    );
  }
}