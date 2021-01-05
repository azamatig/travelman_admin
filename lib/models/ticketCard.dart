import 'package:cloud_firestore/cloud_firestore.dart';

class TicketCard{
  String origin;
  String destination;
  String depDate;
  String arrDate;
  String price;
  String airline;
  String timestamp;
  String clientName;
  String clientEmail;
  String clientPhone;
  String clientAvatar;

  TicketCard({this.origin, this.destination,
    this.depDate, this.arrDate, this.price, this.airline, this.timestamp,
    this.clientName, this.clientEmail, this.clientPhone, this.clientAvatar});

  factory TicketCard.fromFirestore(DocumentSnapshot snapshot){
    var d = snapshot.data();
    return TicketCard(
      origin: d['origin'],
      destination: d['destination'],
      depDate: d['depDate'],
      arrDate: d['arrDate'],
      price: d['price'],
      airline: d['airline'],
      timestamp: d['timestamp'],
      clientName: d['clientName'],
      clientEmail: d['clientEmail'],
      clientPhone: d['clientPhone'],
      clientAvatar: d['clientAvatar'],
    );
  }
}