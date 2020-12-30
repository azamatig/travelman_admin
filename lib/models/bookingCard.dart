import 'package:cloud_firestore/cloud_firestore.dart';

class BookingCard{
  String hotelName;
  String price;
  String imageUrl;
  String depDate;
  String arrDate;
  String timestamp;
  String clientName;
  String clientEmail;
  String clientPhone;
  String clientAvatar;

  BookingCard({this.hotelName, this.price,
    this.imageUrl, this.depDate, this.arrDate, this.timestamp,
  this.clientName, this.clientEmail, this.clientPhone, this.clientAvatar});
  
  factory BookingCard.fromFirestore(DocumentSnapshot snapshot){
    var d = snapshot.data();
    return BookingCard(
      hotelName: d['hotelName'],
      price: d['price'],
      imageUrl: d['imageUrl'],
      depDate: d['depDate'],
      arrDate: d['arrDate'],
      timestamp: d['timestamp'],
      clientName: d['clientName'],
      clientEmail: d['clientEmail'],
      clientPhone: d['clientPhone'],
      clientAvatar: d['clientAvatar'],
    );
  }
}